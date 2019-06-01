provider "matchbox" {
  version     = "0.2.3"
  endpoint    = "${var.matchbox_rpc_endpoint}"
  client_cert = "${file("../matchbox/etc/tls/client.crt")}"
  client_key  = "${file("../matchbox/etc/tls/client.key")}"
  ca          = "${file("../matchbox/etc/tls/ca.crt")}"
}

provider "ct" {
	version = "0.3.1"
}

provider "local" {
	version = "~> 1.0"
	alias = "default"
}

provider "null" {
	version = "~> 1.0"
	alias = "default"
}

provider "template" {
	version = "~> 1.0"
	alias = "default"
}

provider "tls" {
	version = "~> 1.0"
	alias = "default"
}
