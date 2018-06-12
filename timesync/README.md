# If nodes are out of sync 
### e.g. 
`ceph status`
### gives mons out of sync warning, then copy timesyncd.conf into /etc/systemd/ of every node in the cluster and RUN 
`sudo systemctl restart systemd-timesyncd`
### on each node
To check that timesync is correctly configured RUN 
`systemctl status systemd-timesyncd`
after systemd-timesyncd is restarted.
