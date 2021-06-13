#!/bin/bash

echo "192.168.99.100 master.dob.lab master" >> /etc/hosts
echo "192.168.99.102 slave.dob.lab slave" >> /etc/hosts

echo "* Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl wget gnupg lsb-release

echo "* Install Java 8"
sudo apt-get install -y openjdk-8-jre

echo "* Import the GPG keys of the Jenkins repository using the following wget command"
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

echo "* add the Jenkins repository to the system with"
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "* Update and Install Jenkins"
sudo apt-get update
sudo apt-get install -y jenkins
