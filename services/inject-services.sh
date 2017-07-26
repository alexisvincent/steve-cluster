sudo cp ./dnsmasq.service /etc/systemd/system/dnsmasq.service
sudo cp ./matchbox.service /etc/systemd/system/matchbox.service
sudo cp ./cluster-config.service /etc/systemd/system/cluster-config.service

sudo systemctl daemon-reload
sudo systemctl stop dnsmasq
sudo systemctl stop matchbox
sudo systemctl stop cluster-config
sudo systemctl start cluster-config
sudo systemctl start matchbox
sudo systemctl start dnsmasq