#!/bin/bash

# Bypass all configuration prompts.
export DEBIAN_FRONTEND=noninteractive

#################
# Linux Goodies #
#################
apt-get update
apt-get install -y curl git-core python-software-properties

##########
# Apache #
##########
apt-get install apache2 -y
echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf
a2enmod ssl rewrite

#########
# MySQL #
#########
apt-get install -y mysql-server
mysql -uroot -e "create database d8"

#######
# PHP #
#######
add-apt-repository -y ppa:ondrej/php5
apt-get update
apt-get install -y php5 libapache2-mod-php5 php5-mysql php5-gd

#################
# Virtual Hosts #
#################
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/d8.conf
cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/d8-ssl.conf
sed -i 's/#ServerName www.example.com/ServerName sbx.d8.dev/g' /etc/apache2/sites-available/d8*
sed -i 's/\/var\/www\/html/\/var\/www\/html\/d8/g' /etc/apache2/sites-available/d8*
a2ensite d8 d8-ssl
service apache2 restart

#########
# Drush #
#########
curl -sS https://getcomposer.org/installer | php
mv /home/vagrant/composer.phar /usr/local/bin/composer
su - vagrant -c 'composer global require drush/drush:dev-master'
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /home/vagrant/.bashrc
sed -i '/DocumentRoot \/var\/www\/html\/d8/a \t<directory /var/www/html/d8/>\n\tAllowOverride All\n\t</directory>' /etc/apache2/sites-available/d8.conf
