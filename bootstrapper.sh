curl https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-x86.tar.xz > /usr/local/bin/node
sudo git clone https://github.com/alexisvincent/steve-cluster-config /etc/cluster-config
cd /etc/cluster-config
node steve.js bootstrap