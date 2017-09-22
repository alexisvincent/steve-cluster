provider "matchbox" {
  endpoint    = "${var.matchbox_rpc_endpoint}"
  client_cert = "${file("../matchbox/etc/tls/client.crt")}"
  client_key  = "${file("../matchbox/etc/tls/client.key")}"
  ca          = "${file("../matchbox/etc/tls/ca.crt")}"
}
