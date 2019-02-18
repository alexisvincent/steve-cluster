# If nodes are out of sync 
### e.g. 
`ceph status`
### gives mons out of sync warning, then copy timesyncd.conf into /etc/systemd/ of every node in the cluster 
RUN 
`for i in $(seq 2 14); do cat /opt/cluster-config/timesync/timesyncd.conf | ssh n${i} "sudo cat >> temp.txt && sudo mv temp.txt /etc/systemd/timesyncd.conf && sudo systemctl restart systemd-timesyncd"; done`

