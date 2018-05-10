# the base image to Ubuntu
FROM ubuntu:17.10

# Update the repository sources list
RUN apt-get update && apt-get install -y openssh-server -y wget -y unzip -y openssh-server -y python-pip -y vim -y sudo -y curl -y docker.io -y git

RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.10.1/bin/linux/amd64/kubectl

RUN mkdir -p /home/.bin && cp ./kubectl /home/.bin/kubectl && chmod +x /home/.bin/kubectl

RUN mkdir -p /var/run/sshd 
RUN mkdir -p /home/<username>
RUN mkdir -p /home/steve

COPY bashrc /home/<username>/.bashrc

WORKDIR /home/<username>

CMD ["/usr/sbin/sshd", "-D"]
