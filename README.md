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
To start:
Spawn up a coreos vm from an optical disk, with enough memory, 3GB might be alright.

Set its network settings:

`/etc/systemd/network/gateway.network`

```
[Match]
Name=enp0s3 # the local network interface

[Network]
Address=10.10.0.1/16
```

then reload network settings
`sudo systemctl restart systemd-networkd`

Set a password for the instance
sudo passwd core

then switch to ssh
```
ssh core@10.10.0.1
```
go to your local copy of steve-config
run `./steve push 10.10.0.1`

on the ssh terminal run `./steve matchbox`
on the ssh terminal cd to terraform and run `terraform init`
