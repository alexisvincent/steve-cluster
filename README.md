# steve-cluster

```
curl https://raw.githubusercontent.com/alexisvincent/steve-cluster-config/master/bootstrapper.sh | bash
```


To start:
Spawn up a coreos vm from an optical disk, with enough memory, 3GB might be alright.

Set its network settings:

`/etc/systemd/network/gateway.network`
`
[Match]
Name=enp0s3 # the local network interface

[Network]
Address=10.10.0.1/16
`

then reload network settings `sudo systemctl restart systemd-networkd`

Set a password for the instance
sudo passwd core

then switch to ssh
ssh core@10.10.0.1

go to your local copy of steve-config
run `./steve push 10.10.0.1`

on the ssh terminal run `./steve matchbox`
on the ssh terminal cd to terraform and run `terraform init`
