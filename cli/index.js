yaml = require('js-yaml');
fs   = require('fs');
Mustache = require('mustache')
  Mustache.tags = ['{|', '|}']

// Get document, or throw exception on error
try {
  const variables = yaml.safeLoad(fs.readFileSync('../variables.yaml', 'utf8'));

  const profile_gateway = fs.readFileSync('../matchbox/profiles/gateway.json', 'utf8');
  const profile_gateway_gen = Mustache.render(profile_gateway, variables)
  fs.writeFileSync(`../matchbox/profiles/gateway.gen.json`, profile_gateway_gen)

  const gateway_ignition_raw = fs.readFileSync('../matchbox/ignition/gateway.yaml', 'utf8')
  const gateway_ignition_with_globals = Mustache.render(gateway_ignition_raw, variables);
  fs.writeFileSync('../matchbox/ignition/gateway.gen.yaml', gateway_ignition_with_globals)
  
  variables.network.gateway = variables.network.bootstrapper

  const gateway_ignition_with_globals_bootstrapper = Mustache.render(gateway_ignition_raw, variables);
  const gateway_ignition = yaml.safeLoad(gateway_ignition_with_globals_bootstrapper);
  gateway_ignition.systemd.units.forEach((unit) => fs.writeFileSync(`../services/${unit.name}`, unit.contents)) 

} catch (e) {
  console.log(e);
}