matchbox_http_endpoint = "http://10.10.0.1:8080"
matchbox_rpc_endpoint = "10.10.0.1:8081"

ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPyp/BkeSqDp2D5/cEFLWr78yK3NFIgFT+uejfYcyj9EMHtTo2B7AmjxNJojnw1qIbzesbs9HIdzJRd3LzifNjEiBrZ1NCwKfFYPQq8UDtoTJWrXAyPpR0p5BtymqrwLkvjMSYyymSnszCAURIQp3mhod01EBt83p3BEH9a2LBgIHkMKuJaUlSJxWCaqwSx7V/j4V+EHNaFOGaAxGphYdYi6J4VErkq6bjxZNL6dvSrh7M8dXtVbwfK7qRwT2fFnwt7F7KjO+AtLx4Now8bgcvh6whaHfyH/pzjUMQmx3gqa1yYnHlDKZbKc4fUju33g6hWl8y5u5ookOTftBrZczJ core@n1"

cluster_name = "steve"
os_version = "1967.3.0"
os_channel = "coreos-stable"

# Machines
controller_names = ["n2"]
controller_macs = ["00:1E:4F:28:30:12"]
#controller_domains = ["n2.steve"]
controller_domains = ["n2"]
worker_names = ["n3","n4","n5","n7","n8","n9","n10","n11","n12","n13","n14"]
worker_macs = [
    "00:22:19:AB:7E:78",
    "00:22:19:8E:15:77",
    "00:1E:C9:D0:AA:9E",
    "00:22:19:8E:25:A1",
    "00:22:19:8E:26:00",
    "00:1E:C9:D0:AA:BC",
    "00:1A:A0:15:E3:76",
    "00:1D:09:05:9A:C0",
    "00:1A:A0:26:DA:B6",
    "00:1D:09:05:98:DC",
    "78:2B:CB:55:54:25"
    ]
#worker_domains = ["n3.steve","n4.steve","n5.steve","n7.steve","n8.steve","n9.steve","n10.steve","n11.steve","n12.steve","n13.steve","n14.steve"]

worker_domains = ["n3", "n4", "n5", "n7", "n8", "n9", "n10", "n11", "n12", "n13", "n14"]

# Testing VMs; comment above and uncomment here to setup local cluster
# controller_names = ["vm2"]
# controller_macs = ["00:50:56:30:35:90"]
# controller_domains = ["vm2.steve"]
# worker_names = ["vm3"]
# worker_macs = ["00:50:56:30:35:91"]
# worker_domains = ["vm3.steve"]

# Bootkube
k8s_domain_name = "steve"
asset_dir = "assets"

# Optional (defaults)
cached_install = "true"
# install_disk = "/dev/sda"
# container_linux_oem = "vmware_raw"
# experimental_self_hosted_etcd = "false"

// Gateway
network_domain = "steve"
subnet_long = "255.255.0.0"
subnet_short = "16"
dhcp_start = "10.10.100.50"
dhcp_end = "10.10.100.100"
gateway_address = "10.10.0.1"
