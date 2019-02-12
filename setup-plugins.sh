wget https://github.com/coreos/terraform-provider-matchbox/releases/download/v0.2.2/terraform-provider-matchbox-v0.2.2-linux-amd64.tar.gz
tar xzf terraform-provider-matchbox-v0.2.2-linux-amd64.tar.gz
mv terraform-provider-matchbox-v0.2.2-linux-amd64/terraform-provider-matchbox terraform/terraform.d/plugins/linux_amd64/terraform-provider-matchbox

wget https://github.com/coreos/terraform-provider-ct/releases/download/v0.3.0/terraform-provider-ct-v0.3.0-linux-amd64.tar.gz
tar xzf terraform-provider-ct-v0.3.0-linux-amd64.tar.gz
mv terraform-provider-ct-v0.3.0-linux-amd64/terraform-provider-ct terraform/terraform.d/plugins/linux_amd64/terraform-provider-ct_v0.3.0
