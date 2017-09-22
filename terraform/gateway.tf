data "template_file" "cl_gateway" {
  template = "${file("./cl/gateway.yaml")}"
  vars {
    network_domain = "${var.network_domain}"
    subnet_long = "${var.subnet_long}"
    subnet_short = "${var.subnet_short}"
    dhcp_start = "${var.dhcp_start}"
    dhcp_end = "${var.dhcp_end}"
    gateway_address = "${var.gateway_address}"
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

// Match a bare-metal machine
resource "matchbox_group" "gateway-1" {
  name = "gateway-1"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:1e:c9:d0:9e:e2"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "gateway-1"
    pynetkey = "true"
    interface_internal = "eno1"
    interface_external = "eno2"
    address_internal = "10.10.0.2"
  }
}

resource "matchbox_group" "gateway-2" {
  name = "gateway-1"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:0C:29:90:A9:FD"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "gateway-2"
    pynetkey = "false"
    interface_internal = "ens34"
    interface_external = "ens33"
    address_internal = "10.10.0.3"
  }
}


resource "matchbox_group" "gateway-3" {
  name = "gateway-3"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:0c:29:8f:62:22"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "gateway-3"
    pynetkey = "false"
    interface_internal = "ens34"
    interface_external = "ens33"
    address_internal = "10.10.0.4"
  }
}

resource "matchbox_group" "node-2" {
  name = "node-2"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:0c:29:8f:62:22"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "node-2"
    pynetkey = "false"
    interface_internal = "ens34"
    interface_external = "ens33"
    address_internal = "10.10.0.4"
  }
}

resource "matchbox_group" "node-3" {
  name = "node-3"
  profile = "${matchbox_profile.gateway.name}"
  selector {
    mac = "00:22:19:ab:7e:76"
    os = "installed"
  }
  metadata {
    ssh_authorized_key = "${var.ssh_authorized_key}"
    hostname = "node-3"
    pynetkey = "false"
    interface_internal = "ens34"
    interface_external = "ens33"
    address_internal = "10.10.0.8"
  }
}