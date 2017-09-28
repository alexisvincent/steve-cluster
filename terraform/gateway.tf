data "template_file" "cl_gateway" {
  template = "${file("./cl/gateway.yaml")}"
  vars {
    network_domain = "${var.network_domain}"
    subnet_long = "${var.subnet_long}"
    subnet_short = "${var.subnet_short}"
    dhcp_start = "${var.dhcp_start}"
    dhcp_end = "${var.dhcp_end}"
    gateway_address = "${var.gateway_address}"
    dnsmasq_conf = <<EOF
          address=/gateway.${var.network_domain}/10.10.0.1

          address=/n1.${var.network_domain}/10.10.1.1
          address=/n2.${var.network_domain}/10.10.1.2
          address=/n3.${var.network_domain}/10.10.1.3
          address=/n4.${var.network_domain}/10.10.1.4
          address=/n5.${var.network_domain}/10.10.1.5
          address=/n6.${var.network_domain}/10.10.1.6
          address=/n7.${var.network_domain}/10.10.1.7
          address=/n8.${var.network_domain}/10.10.1.8

          address=/vm1.${var.network_domain}/10.10.10.1
          address=/vm2.${var.network_domain}/10.10.10.2
          address=/vm3.${var.network_domain}/10.10.10.3
          address=/vm4.${var.network_domain}/10.10.10.4
          address=/vm5.${var.network_domain}/10.10.10.5
          address=/vm6.${var.network_domain}/10.10.10.6
          address=/vm7.${var.network_domain}/10.10.10.7
          address=/vm8.${var.network_domain}/10.10.10.8

          dhcp-host=00:1e:4f:28:30:10,10.10.1.1
          dhcp-host=00:22:19:8e:15:77,10.10.1.4

          dhcp-host=00:0C:29:8F:62:18,10.10.10.1
          dhcp-host=00:0C:29:90:A9:F3,10.10.10.2
          dhcp-host=00:50:56:3A:09:94,10.10.10.3
          dhcp-host=00:0C:29:44:0C:18,10.10.10.4
EOF
  }
}

resource "matchbox_profile" "gateway" {
  name = "gateway"
  kernel = "/assets/coreos/${var.container_linux_version}/coreos_production_pxe.vmlinuz"
  initrd = [
    "/assets/coreos/${var.container_linux_version}/coreos_production_pxe_image.cpio.gz"
  ]

  args = [
    "coreos.config.url=http://${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
    "coreos.first_boot=yes",
    "console=tty0",
    "console=ttyS0",
    "coreos.autologin"
  ]

  container_linux_config = "${data.template_file.cl_gateway.rendered}"
}

resource "matchbox_group" "install-reboot" {
  name = "install-reboot"
  profile = "cached-container-linux-install"
  selector {
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
  }
}

resource "matchbox_group" "n1" {
  name = "n1"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:22:19:8E:26:AC"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "n1"
    pynetkey = "true"
    interface_internal = "eno2"
    interface_external = "eno1"
    address_internal = "10.10.1.1"
  }
}

# resource "matchbox_group" "n1" {
#   name = "n1-gateway"
#   profile = "${matchbox_profile.gateway.name}"
#   selector {
#     mac = "00:1e:4f:28:30:12"
#     os = "installed"
#   }
#   metadata {
#     ssh_authorized_key = "${var.ssh_authorized_key}"
#     hostname = "n1"
#     pynetkey = "true"
#     interface_internal = "eno2"
#     interface_external = "eno1"
#     address_internal = "10.10.1.1"
#   }
# }

# resource "matchbox_group" "n20" {
#   name = "n20-gateway"
#   profile = "${matchbox_profile.gateway.name}"
#   selector {
#     mac = "00:1e:c9:d0:9e:e4"
#     os = "installed"
#   }
#   metadata {
#     ssh_authorized_key = "${var.ssh_authorized_key}"
#     hostname = "n20"
#     pynetkey = "true"
#     interface_internal = "eno2"
#     interface_external = "eno1"
#     address_internal = "10.10.1.20"
#   }
# }

# resource "matchbox_group" "n4" {
#   name = "n4-gateway"
#   profile = "${matchbox_profile.gateway.name}"
#   selector {
#     mac = "00:22:19:8e:15:77"
#     os = "installed"
#  }
#   metadata {
#     ssh_authorized_key = "${var.ssh_authorized_key}"
#     hostname = "n4"
#     pynetkey = "true"
#     interface_internal = "eno2"
#     interface_external = "eno1"
#     address_internal = "10.10.1.1"
#   }
# }

# resource "matchbox_group" "vm1" {
#   name = "vm1-gateway"
#   profile = "${matchbox_profile.gateway.name}"
#   selector {
#     mac = "00:0C:29:8F:62:18"
#     os = "installed"
#   }
#   metadata {
#     ssh_authorized_key = "${var.ssh_authorized_key}"
#     hostname = "vm1"
#     pynetkey = "false"
#     interface_internal = "ens33"
#     interface_external = "ens34"
#     address_internal = "10.10.10.1"
#   }
# }

# resource "matchbox_group" "vm2" {
#   name = "vm2-gateway"
#   profile = "${matchbox_profile.gateway.name}"
#   selector {
#     mac = "00:0C:29:90:A9:F3"
#     os = "installed"
#   }
#   metadata {
#     ssh_authorized_key = "${var.ssh_authorized_key}"
#     hostname = "vm2"
#     pynetkey = "false"
#     interface_internal = "ens33"
#     interface_external = "ens34"
#     address_internal = "10.10.10.2"
#   }
# }