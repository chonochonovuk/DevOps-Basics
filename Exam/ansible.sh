echo "* Add hosts ..."
echo "192.168.120.100 avm.dob.exam ansible" >> /etc/hosts
echo "192.168.120.101 jvm.dob.exam jenkins" >> /etc/hosts
echo "192.168.120.102 nvm.dob.exam nagios" >> /etc/hosts
echo "192.168.120.103 dvm.dob.exam docker" >> /etc/hosts

echo "* Install Ansible ..."
sudo apt-get update -y
sudo apt-get install -y ansible

echo "* Install Ansible role(s) for jenkins and java in /ansible/roles/ ..."
ansible-galaxy install geerlingguy.jenkins -p /ansible/roles/
ansible-galaxy install geerlingguy.java -p /ansible/roles/
