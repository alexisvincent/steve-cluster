#! /usr/bin/bash
# Install kubectl
rm /home/core/.bin/kubectl
curl -O https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl
mkdir -p /home/core/.bin
mv ./kubectl /home/core/.bin/kubectl
chown core /home/core/.bin/kubectl
chmod +x /home/core/.bin/kubectl
