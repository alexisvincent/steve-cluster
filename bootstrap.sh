sudo mkdir -p /opt
sudo chown /opt
mkdir -p /opt/bin
curl -o /opt/bin/node https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-x86.tar.xz
git clone https://github.com/alexisvincent/steve-cluster-config /opt/cluster-config
cd /etc/cluster-config
node steve.js bootstrap