const yaml = require('js-yaml');
const fs   = require('fs');
const vorpal = require('vorpal')();
const path = require('path');
const Mustache = require('mustache')
const { exec } = require('child_process');
Mustache.tags = ['{|', '|}']

process.chdir(__dirname)

const variables = yaml.safeLoad(fs.readFileSync('./variables.yaml', 'utf8'));

vorpal
  .command('compile', 'compile source files (substitute variables)')
  .action(function(args, cb) {

    // profiles/gateway.json -> profiles/gateway.gen.json
    const profiles_gateway = fs.readFileSync('matchbox/profiles/gateway.json', 'utf8');
    fs.writeFileSync(`matchbox/profiles/gateway.gen.json`, Mustache.render(profiles_gateway, variables))

    // ignition/gateway.yaml -> ignition/gateway.gen.yaml
    const gateway_ignition = fs.readFileSync('matchbox/ignition/gateway.yaml', 'utf8')
    fs.writeFileSync('matchbox/ignition/gateway.gen.yaml', Mustache.render(gateway_ignition, variables))
    this.log(__root)
    
    // bootstrapper service files
    variables.network.gateway = variables.network.bootstrapper
    const gateway_ignition_bootstrapper = yaml.safeLoad(Mustache.render(gateway_ignition, variables));
    gateway_ignition_bootstrapper.systemd.units
      .filter(unit => ['matchbox.service', 'dnsmasq.service'].includes(unit.name))
      .forEach((unit) => fs.writeFileSync(`bootstrapper/services/${unit.name}`, unit.contents)) 
    gateway_ignition_bootstrapper.networkd.units.forEach((unit) => fs.writeFileSync(`bootstrapper/network/${unit.name}`, unit.contents)) 

    this.log('compiling... done');
    cb();
  });

vorpal
  .command('reload services', 'inject and reload systemd services')
  .action(function(args, cb) {
    this.log('injecting services...')
    exec(`
    sudo cp bootstrapper/services/dnsmasq.service /etc/systemd/system/dnsmasq.service
    sudo cp bootstrapper/services/matchbox.service /etc/systemd/system/matchbox.service
    sudo cp bootstrapper/services/cluster-config.service /etc/systemd/system/cluster-config.service

    sudo systemctl daemon-reload

    sudo systemctl stop cluster-config
    sudo systemctl stop matchbox
    sudo systemctl stop dnsmasq

    sudo systemctl start cluster-config
    sudo systemctl start matchbox
    sudo systemctl start dnsmasq
    `, (err, stdout, stderr) => {
      this.log(stdout)
      this.log(stderr)
      this.log('done')
      cb();
    })

  });

vorpal
  .command('reload network', 'inject and reload networkd config')
  .action(function(args, cb) {

  });

vorpal.parse(process.argv);
vorpal
  .delimiter('steve >')
  .show();