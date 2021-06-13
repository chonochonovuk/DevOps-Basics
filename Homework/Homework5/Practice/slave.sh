#!/bin/bash

echo "192.168.99.100 master.dob.lab master" >> /etc/hosts
echo "192.168.99.102 slave.dob.lab slave" >> /etc/hosts

echo "* Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "* Install Java 8"
sudo apt-get install -y openjdk-8-jre

echo "* Import the GPG keys of the Jenkins repository using the following wget command"
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

echo "* add the Jenkins repository to the system with"
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "* Update and Install Jenkins"
sudo apt-get update
sudo apt-get install -y jenkins

echo "* Add Docker’s official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "* set up the stable repository"
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 

echo "* Install Docker ..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "* Enable and start Docker ..."
sudo systemctl enable docker
sudo systemctl start docker

echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant
usermod -aG docker jenkins

echo "* Download the current stable release of Docker Compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "* Apply executable permissions to the binary ..."
sudo chmod +x /usr/local/bin/docker-compose
 
