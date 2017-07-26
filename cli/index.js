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
  
  const gateway_ignition = yaml.safeLoad(gateway_ignition_with_globals);
  const profile_variables = variables.network.bootstrapper
  gateway_ignition.systemd.units.forEach(function(unit) {
    Mustache.tags = ["{{", "}}"]
     const unit_with_profile_variables = Mustache.render(unit.contents, profile_variables);
     fs.writeFileSync(`../services/${unit.name}`, unit_with_profile_variables)
  }) 

} catch (e) {
  console.log(e);
}