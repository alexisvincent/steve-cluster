# DNS or IP Subject Alt Names where matchbox runs
export SAN=DNS.1:matchbox.cluster,IP.1:10.10.0.1
cp ca.crt server.crt server.key ../../../steve-cluster/matchbox/etc