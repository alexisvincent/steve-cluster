#! /usr/bin/bash
rm /home/core/.bashrc
cp ./bashrc /home/core/.bashrc

# Install kubectl
rm /home/core/.bin/kubectl
curl -O https://storage.googleapis.com/kubernetes-release/release/v1.10.1/bin/linux/amd64/kubectl
mkdir -p /home/core/.bin
mv ./kubectl /home/core/.bin/kubectl
chown core /home/core/.bin/kubectl
chmod +x /home/core/.bin/kubectl

# Install Terraform
rm /home/core/.bin/terraform
wget -O /home/core/.bin/terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
unzip -p /home/core/.bin/terraform.zip > /home/core/.bin/terraform
rm /home/core/.bin/terraform.zip
chmod +x /home/core/.bin/terraform

# Install Helm
rm /home/core/.bin/helm
wget -O /home/core/.bin/helm.tar.gz wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.0-linux-amd64.tar.gz
tar -zxvf /home/core/.bin/helm.tar.gz
rm /home/core/.bin/helm.tar.gz
mv /home/core/.bin/linux-amd64/helm /home/core/.bin/helm
rm -r /home/core/.bin/linux-amd64
chmod +x /home/core/.bin/helm
helm init 

# Install StorageOS
rm /home/core/.bin/storageos
curl -sSLo /home/core/.bin/storageos https://github.com/storageos/go-cli/releases/download/0.10.0/storageos_linux_amd64 
chmod +x /home/core/.bin/storageos
