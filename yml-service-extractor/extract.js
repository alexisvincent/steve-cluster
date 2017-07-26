yaml = require('js-yaml');
fs   = require('fs');
Mustache = require('mustache')

// Get document, or throw exception on error
try {
  var doc = yaml.safeLoad(fs.readFileSync('../matchbox/ignition/gateway.yaml', 'utf8'));

  const units = doc.systemd.units

  var variables = {
    gateway_address: "10.10.0.2",
    gateway_interface: "ens34",
    gateway_hostname: "gateway_temp.steve"
  };

  units.forEach(function(unit) {
     const rendered = Mustache.render(unit.contents, variables);
     fs.writeFileSync(`../services/${unit.name}`, rendered)
  }) 

} catch (e) {
  console.log(e);
}