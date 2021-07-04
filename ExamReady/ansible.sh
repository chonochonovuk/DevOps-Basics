echo "* Add hosts ..."
echo "192.168.99.100 ansible.dob.lab ansible" >> /etc/hosts
echo "192.168.99.101 jenkins.dob.lab jenkins" >> /etc/hosts
echo "192.168.99.102 nagios.dob.lab nagios" >> /etc/hosts
echo "192.168.99.103 docker.dob.lab docker" >> /etc/hosts

echo "* Install Ansible ..."
sudo apt-get update -y
sudo apt-get install -y ansible

echo "* Install Ansible role(s) for jenkins and java in /ansible/roles/ ..."
ansible-galaxy install geerlingguy.jenkins -p /ansible/roles/
ansible-galaxy install geerlingguy.java -p /ansible/roles/
