sudo mkdir -p /opt
sudo chown core /opt
mkdir -p /opt/bin
curl -o /opt/bin/node https://github.com/zeit/pkg-fetch/releases/download/v2.3/uploaded-v2.3-node-v8.0.0-linux-x86
git clone https://github.com/alexisvincent/steve-cluster-config /opt/cluster-config
cd /opt/cluster-config
node steve.js bootstrap