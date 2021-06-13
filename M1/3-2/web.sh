#!/usr/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.dob.lab web" >> /etc/hosts
echo "192.168.89.101 db.dob.lab db" >> /etc/hosts

echo "* Install Software ..."
sudo apt-get upgrade -y
sudo apt-get install -y apache2 php php-mysqlnd git

echo "* Start HTTP ..."
sudo systemctl enable apache2
sudo systemctl start apache2

#echo "* Firewall - open port 80 ..."
#sudo firewall-cmd --add-port=80/tcp --permanent
#sudo firewall-cmd --reload

echo "* Copy web site files to /var/www/html/ ..."
cp /vagrant/* /var/www/html

#echo "* Allow HTTPD to make network connections ..."
#sudo setsebool -P httpd_can_network_connect=1
