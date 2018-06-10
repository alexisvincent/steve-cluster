# Steve
A kubernetes cluster. Doesn't like cats.

## Why Kubernetes?
There's so many reasons. But in short.
- Proven Technology
- Containerized Workflows
- Massive Community
- Run processes on bare metal, skip virtulisation cost, portability through containers
- Simple management
- Trivial cluster growth, just plug machines in and add network MAC to config

## Goals
### Infrastructure as Code
All infrastructure settings are codified in this repository and managed with Terraform. This simplifies extension and growth of the cluster and increases visibility into how everything works.

If the cluster breaks in an unrecoverable manner, just re-bootstrap it from scratch. Should take under an hour (only this long because our servers are really slow to boot).

### Automation
We want setup and management to require minimal human input. Towards this end:
- Nodes in the cluster perform automatic OS upgrades as new versions become available.
- All nodes automatically wipe disk, install OS from network via PXE, and connect to the cluster. When node config changes, just PXE boot it again.
- When nodes die, all work they were running is rescheduled onto available nodes.
- Mostly automated cluster bootstrapping

### Simplicity
Simplicity is a prerequisite of resiliency. To this end, favour simplicity over all else.
The cluster should be simple to bootstrap, manage, update, evolve and use. If this comes at the cost of performance, so be it.

We're using the Typhoon Kubernetes distribution managed via Terraform, which integrates seamlessly with the rest of the infrastructure. This means we don't have to think about how to manage the Kubernetes cluster itself.

Where possible, infrastructure is controlled with Terraform.

## Bootstap the cluster
### To start:
Spawn up a coreos vm from an optical disk, with enough memory, 3GB might be alright.

Set its network settings:

`/etc/systemd/network/gateway.network`

```
[Match]
Name=enp0s3 # the local network interface

[Network]
Address=10.10.0.1/16
```

Then reload network settings
`sudo systemctl restart systemd-networkd`

Set a password for the instance
sudo passwd core

Run
```
git clone https://github.com/alexisvincent/steve-cluster-config.git
mv steve-cluster-config cluster-config
```
Run `./steve push 10.10.0.1`

Then switch to ssh
```
ssh core@10.10.0.1
```

On the ssh terminal:
Generate new TLS certs and start matchbox
```
cd /opt/cluster-config/matchbox/etc/
./generate-tls.sh
cd /opt/cluster-config
./steve matchbox
```
Download terraform and initalise node configs
```
cd /opt/cluster-config/terraform
./terraform_dl.sh
terraform init
terraform apply (yes when prompted)
stop process once you see "module.kubernetes.null_resource.copy-worker-secrets.3: Still creating... (10s elapsed)"
cd /opt/cluster-config
./steve ignition
```
Restart the vm --> this time it should boot coreOS from virtual disk and not optical disk.

!!!Everything from here till the next "!!!" needs work and should be read with caustion!!!

At this point you should be able to connect a gateway node to your machine running the VM and PXE-boot the node.

Generate new ssh keys
```
cd /opt/cluster-config/terraform
./genNewKeys.sh (with no passwd)
```
Start the ssh-agent and complete cluster bootstrap
```
cd /opt/cluster-config/terraform
exec ssh-agent bash
ssh-add ~/.ssh/id_rsa && ssh-add -L
terraform apply
wait for it to finish (Can take 20 min)
```

!!!You should be fine from here!!!

## Re-bootstrapping Steve when the gateway is already configured:
### From the gateway:
`cd /opt`
Remove the previous cluster config or just store it in a different backup folder to be deleted later.
Then clone a fresh config from github
```
git clone https://github.com/alexisvincent/steve-cluster-config.git
mv steve-cluster-config cluster-config
```
Generate new TLS certs
```
cd cluster-config/matchbox/etc
./generate-tls.sh
```
Download coreOS
```
cd ../../
./steve download_coreos
```
Downlaod kubectl (if not done before)
`./steve download_kubectl`
Generate new ssh keys
```
cd terraform
./genNewKeys.sh (with no passwd)
```
Generate node config files
```
rm terraform.tfstate*
terraform init
sudo systemctl restart matchbox
terraform apply (yes when prompted)
stop process once you see "module.kubernetes.null_resource.copy-worker-secrets.3: Still creating... (10s elapsed)"
```
PXE-boot all the nodes (startup followed by f12). Ping each node (n2.steve -n14.steve) to check that they are up.
Start the ssh-agent and complete cluster bootstrap
```
cd /opt/cluster-config/terraform
exec ssh-agent bash
ssh-add ~/.ssh/id_rsa && ssh-add -L
terraform apply
wait for it to finish (Can take 20 min)
```
If /opt/cluster-config/ does not contain assets.ready.processed then the following line is necessary should node 1 ever reboot.
`touch /opt/cluster-config/assets.ready`
Check that Kubernetes sees all the nodes. This might take a while (possibly 5 mins, but probably an hour)
`watch -n1 kubectl get nodes`

The cluster should now be fully bootstrapped and ready to go. Consider setting up the distributed storage (found in rook), the registry (found in registry) and heapster (for monitoring the cluster stats) next.

