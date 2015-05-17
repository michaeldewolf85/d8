#!/bin/bash

# Bypass all configuration prompts.
export DEBIAN_FRONTEND=noninteractive

apt-get update

##########
# Apache #
##########
apt-get install apache2 -y
echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf
a2enmod ssl

#########
# MySQL #
#########
apt-get install -y mysql-server

#######
# PHP #
#######
apt-get install -y php5 libapache2-mod-php5 php5-mysql

################
# Virtual Host #
################
cp /etc/apache2/sites-available/default /etc/apache2/sites-available/d8
cp /etc/apache2/sites-available/default-ssl /etc/apache2/sites-available/d8-ssl
sed -i '/ServerAdmin webmaster@localhost/a\\tServerName sbx.d8.dev' /etc/apache2/sites-available/d8*
sed -i 's/\/var\/www/\/vagrant\/docroot/g' /etc/apache2/sites-available/d8*
a2ensite d8 d8-ssl
service apache2 restart

