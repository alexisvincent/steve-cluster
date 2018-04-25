#! /usr/bin/bash
rm /home/core/.bashrc
cp ./bashrc /home/core/.bashrc

# Install kubectl
rm ~/.bin/kubectl
curl -O https://storage.googleapis.com/kubernetes-release/release/v1.10.1/bin/linux/amd64/kubectl
mkdir -p /home/core/.bin
mv ./kubectl /home/core/.bin/kubectl
chown core /home/core/.bin/kubectl
chmod +x /home/core/.bin/kubectl

# Install Terraform
rm ~/.bin/terraform
wget -O /home/core/.bin/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip -p /home/core/.bin/terraform.zip > /home/core/.bin/terraform
rm /home/core/.bin/terraform.zip
chmod +x /home/core/.bin/terraform
