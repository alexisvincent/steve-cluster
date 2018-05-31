matchbox_http_endpoint = "http://10.10.0.1:8080"
matchbox_rpc_endpoint = "10.10.0.1:8081"

ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7HL4M6s4J+0flGwennPxn9cpvEzFaCmFZJDFaFP+MtcJIDBHu+3G0wNMux/uBYkAXYyEeUAddlP2EBbkC5E5DbE/gIq2bvt4o+34rQmWklIFuNV3PbIml+Vc3zw2G+T4DmLreVPABT3d6FdFDok28xuy1xs9tSyv/aoTO5YSAvxAQakgSKyrwDcJyCyboQoHxEiWV9rwFJ65XPOio/E0j5I9Lxy4tIf1Hmg7xqTfCnO1xmwhxFrUvsAhDjlcGWw57irLhiQsDbW+zJ4vE1/O+BOtc4Cb+ZQK63IiXUvExJUWo2XiFzBxNJXtkQcSvePBqwRW0pR/D7oI6i0nhYYtb core@n1"

cluster_name = "steve"
os_version = "1745.4.0"
os_channel = "coreos-stable"

# Machines
controller_names = ["n2"]
controller_macs = ["00:1E:4F:28:30:12"]
controller_domains = ["n2.steve"]
worker_names = ["n3","n4","n5","n6","n7","n8","n9","n10","n11","n12","n13","n14"]
worker_macs = [
    "00:22:19:AB:7E:78",
    "00:22:19:8E:15:77",
    "00:1E:C9:D0:AA:9E",
    "00:22:19:8E:26:B6",
    "00:22:19:8E:25:A1",
    "00:22:19:8E:26:00",
    "00:1E:C9:D0:AA:BC",
    "00:1A:A0:15:E3:76",
    "00:1D:09:05:9A:C0",
    "00:1A:A0:26:DA:B6",
    "00:1D:09:05:98:DC",
    "78:2B:CB:55:54:25"
    ]
worker_domains = ["n3.steve","n4.steve","n5.steve","n6.steve","n7.steve","n8.steve","n9.steve","n10.steve","n11.steve","n12.steve","n13.steve","n14.steve"]

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
