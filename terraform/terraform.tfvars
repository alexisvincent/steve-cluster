matchbox_http_endpoint = "http://10.10.0.3:8080"
matchbox_rpc_endpoint = "10.10.0.3:8081"
# matchbox_http_endpoint = "http://localhost:8080"
# matchbox_rpc_endpoint = "localhost:8081"
ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCk8CU3Bi1KFNcfQXpEdxz7HyfY1rh0MnuSVDFRTKcIIfboE5uMj0k7S/K1odIYFafs2Q8QgR/WmaZ15VAu9MvYfnmE9iPuB9PUa8YVkGeAxjIq929RICbYJCAgNen0lWqV9QQiulhU8A76Ot1CbNSIJgND4KbBUfZqjrCTO4lWbkisYwickbyi1j8FSTLcVmHkMYSOcFbueVXQrO6OXZQtLGa8HwRbY6kA3O6klzei1eMMzADLSjCuLKX7q0taYSQk80Joll2txD5bwId3SRvxZAenHrLZLkXzD7k68hxbpmTltMrwdAtOouNzyNuNCLaxEHUygQLxIBGEcOkFNA6e954GPMIf/IV6X4wmAnA9kqBbxGCC6b7KA+e2s8eusEWCA4lie1kJt4aQqImpquqpbft9wHDx16Qsh/Tqj7ZKG7bbPox82N2MRSl+RpxnOIjc8/xIFdrjELOH/zjI4milIT8BiSdGhQjk0ABTZWcVF9nf8eGxtw3oMKyYfhMrZ3+WRny0ut/4cyLwQJdbqi3so4sLJ51A6YLB4kpGRYRb8gChZZFh6uiwMPj057J9VOEbZE6hpQnXgatUMvmNfCFztj4+RmRiFo7l0YXz6DmocxqlEtXR2bOEVYq77Edc/YNDM5lIh5Wl3Bno0qsZ+KXoG7BASgP1qWBY5x25+nXwLQ== alexisvincent@Zeus.local"

cluster_name = "example"
container_linux_version = "1465.7.0"
container_linux_channel = "stable"

# Machines
controller_names = ["controller-1"]
controller_macs = ["00:50:56:3A:09:94"]
controller_domains = ["controller-1.steve"]
worker_names = ["minion-1"]
worker_macs = ["00:0C:29:44:0C:18"]
worker_domains = ["minion-1.steve"]

# Bootkube
k8s_domain_name = "steve"
asset_dir = "assets"

# Optional (defaults)
cached_install = "true"
# install_disk = "/dev/sda"
# container_linux_oem = ""
# experimental_self_hosted_etcd = "false"

// Gateway 
network_domain = "steve"
subnet_long = "255.255.0.0"
subnet_short = "16"
dhcp_start = "10.10.0.50"
dhcp_end = "10.10.0.100"
gateway_address = "10.10.0.1"