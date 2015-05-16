#!/bin/bash

# Bypass all configuration prompts.
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install apache2 -y
# Add a servername to httpd.conf in order to avoid Apache warning.
echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf

apt-get install -y php5 libapache2-mod-php5 mysql-server php5-mysql

