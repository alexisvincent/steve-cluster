# DNS or IP Subject Alt Names where matchbox runs
export SAN=DNS.1:localhost,IP.1:10.10.0.1
cd tls
curl https://raw.githubusercontent.com/coreos/matchbox/master/scripts/tls/openssl.conf -o openssl.conf
curl https://raw.githubusercontent.com/coreos/matchbox/master/scripts/tls/cert-gen | bash
