const yaml = require('js-yaml');
const fs   = require('fs');
const vorpal = require('vorpal')();
const path = require('path');
const Mustache = require('mustache')
const { exec } = require('child_process');
Mustache.tags = ['{|', '|}']

// process.chdir()


vorpal
  .command('compile', 'compile source files (substitute variables)')
  .action(function(args, cb) {

    const variables = yaml.safeLoad(fs.readFileSync('./variables.yaml', 'utf8'));

    // profiles/gateway.json -> profiles/gateway.gen.json
    const profiles_gateway = fs.readFileSync('matchbox/profiles/gateway.json', 'utf8');
    fs.writeFileSync(`matchbox/profiles/gateway.gen.json`, Mustache.render(profiles_gateway, variables))

    // ignition/gateway.yaml -> ignition/gateway.gen.yaml
    const gateway_ignition = fs.readFileSync('matchbox/ignition/gateway.yaml', 'utf8')
    fs.writeFileSync('matchbox/ignition/gateway.gen.yaml', Mustache.render(gateway_ignition, variables))
    
    // bootstrapper service files
    variables.network.gateway = variables.network.bootstrapper
    const gateway_ignition_bootstrapper = yaml.safeLoad(Mustache.render(gateway_ignition, variables));
    gateway_ignition_bootstrapper.systemd.units
      .forEach((unit) => fs.writeFileSync(`bootstrapper/services/${unit.name}`, unit.contents)) 
    gateway_ignition_bootstrapper.networkd.units.forEach((unit) => fs.writeFileSync(`bootstrapper/network/${unit.name}`, unit.contents)) 

    this.log('compiling... done');
    cb();
  });

vorpal
  .command('reload services', 'inject and reload systemd services')
  .action(function(args, cb) {
    this.log('injecting services...')

    const variables = yaml.safeLoad(fs.readFileSync('./variables.yaml', 'utf8'));
    const gateway_ignition = fs.readFileSync('matchbox/ignition/gateway.yaml', 'utf8')
    const gateway_ignition_bootstrapper = yaml.safeLoad(Mustache.render(gateway_ignition, variables));

    this.log('this may take some time... don\'t quit the cli')
    
    exec(`
    ${
      gateway_ignition_bootstrapper.systemd.units
      .map(({name}) => `sudo cp bootstrapper/services/${name} /etc/systemd/system/${name}`)
      .join('\n')
    }
    #sudo cp bootstrapper/services/download-assets.service /etc/systemd/system/download-assets.service
    #sudo cp bootstrapper/services/pynetkey.service /etc/systemd/system/pynetkey.service
    #sudo cp bootstrapper/services/dnsmasq.service /etc/systemd/system/dnsmasq.service
    #sudo cp bootstrapper/services/matchbox.service /etc/systemd/system/matchbox.service

    sudo systemctl daemon-reload

    sudo systemctl stop download-assets
    sudo systemctl stop pynetkey
    sudo systemctl stop matchbox
    sudo systemctl stop dnsmasq

    sudo systemctl start download-assets
    sudo systemctl start pynetkey
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
    this.log('injecting network services...')
    exec(`
    sudo cp bootstrapper/network/gateway.network /etc/systemd/network/gateway.network

    sudo systemctl daemon-reload
    sudo systemctl restart systemd-networkd
    `, (err, stdout, stderr) => {
      this.log(stdout)
      this.log(stderr)
      this.log('done')
      cb();
    })

  });

vorpal
  .command('pull cluster-config <host>', 'download coreos images from remote computer')
  .action(function(args, cb) {
    exec(`
    rsync -r core@${args.host}:/opt/cluster-config/ /opt/cluster-config/matchbox
    `,   (err, stdout, stdin) => {
      this.log(stdout)
      this.log(stderr)
    })
  });

vorpal
  .command('push assets <host>', 'download coreos images from remote computer')
  .action(function(args, cb) {
    exec(`
    scp -r ./matchbox/assets core@${args.host}:/opt/cluster-config/matchbox
    `,   (err, stdout, stderr) => {
      this.log(stdout)
      this.log(stderr)
    })
  });

vorpal.parse(process.argv);
vorpal
  .delimiter('steve >')
  .show();