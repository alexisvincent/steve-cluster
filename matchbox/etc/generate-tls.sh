# DNS or IP Subject Alt Names where matchbox runs
export SAN=DNS.1:matchbox.example.com,IP.1:10.10.0.1
curl https://raw.githubusercontent.com/coreos/matchbox/v0.6.1/scripts/tls/cert-gen | bash