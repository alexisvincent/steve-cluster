wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
unzip terraform_0.11.14_linux_amd64.zip
mv terraform /home/core/.bin/terraform
rm terraform_0.11.14_linux_amd64.zip

wget https://github.com/poseidon/terraform-provider-matchbox/releases/download/v0.2.3/terraform-provider-matchbox-v0.2.3-linux-amd64.tar.gz
tar xzf terraform-provider-matchbox-v0.2.3-linux-amd64.tar.gz
mv terraform-provider-matchbox-v0.2.3-linux-amd64/terraform-provider-matchbox /opt/cluster-config/terraform/terraform.d/plugins/linux_amd64/terraform-provider-matchbox_v0.2.3
rm terraform-provider-matchbox-v0.2.3-linux-amd64.tar.gz && rm -r terraform-provider-matchbox-v0.2.3-linux-amd64

wget https://github.com/poseidon/terraform-provider-ct/releases/download/v0.3.1/terraform-provider-ct-v0.3.1-linux-amd64.tar.gz
tar xzf terraform-provider-ct-v0.3.1-linux-amd64.tar.gz
mv terraform-provider-ct-v0.3.1-linux-amd64/terraform-provider-ct /opt/cluster-config/terraform/terraform.d/plugins/linux_amd64/terraform-provider-ct_v0.3.1
rm terraform-provider-ct-v0.3.1-linux-amd64.tar.gz && rm -r terraform-provider-ct-v0.3.1-linux-amd64
