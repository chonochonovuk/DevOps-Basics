#!/usr/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 manager.dob.lab manager" >> /etc/hosts
echo "192.168.89.101 worker1.dob.lab worker1" >> /etc/hosts
echo "192.168.89.102 worker2.dob.lab worker2" >> /etc/hosts

echo "* Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

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

echo "*Download the current stable release of Docker Compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "*Apply executable permissions to the binary ..."
sudo chmod +x /usr/local/bin/docker-compose

echo "Starting worker1..."
docker swarm join --token $(cat /vagrant/worker) --advertise-addr 192.168.89.102 192.168.89.100:2377
