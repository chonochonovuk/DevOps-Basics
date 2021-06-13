#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 docker.dob.lab docker" >> /etc/hosts

echo "* Add Docker repository ..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker ..."
dnf install -y docker-ce docker-ce-cli

echo "* Enable and start Docker ..."
systemctl enable docker
systemctl start docker

echo "* Firewall - open port 8080 ..."
firewall-cmd --add-port=8080/tcp --permanent

echo "* Firewall - set adapter zone ..."
firewall-cmd --add-interface docker0 --zone trusted --permanent

echo "* Firewall - reload rules ..."
firewall-cmd --reload

echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant
