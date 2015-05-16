#!/bin/bash

# Bypass all configuration prompts.
export DEBIAN_FRONTEND=noninteractive

apt-get update

##########
# Apache #
##########
apt-get install apache2 -y
echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf

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

