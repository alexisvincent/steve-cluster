cp ./dnsmasq.service /etc/systemd/system/dnsmasq.service
cp ./matchbox.service /etc/systemd/system/matchbox.service

sudo systemctl daemon-reload
sudo systemctl stop dnsmasq
sudo systemctl stop matchbox
sudo systemctl start dnsmasq
sudo systemctl start matchbox