#!/bin/bash

apt-get update
apt-get install -y htop iotop vim git curl tree nodejs nodejs-legacy npm strace
npm install bower -g
gem install sass

if [ -d /vagrant/src/PropelSandbox ]; then
    /vagrant/compile_userchroot.sh
else
    echo "!! src/PropelSandbox not checked out !!";
    exit;
fi

# install php
apt-get install -y --force-yes php5-cli php5-fpm php5-mysql php5-xdebug

# install mysql
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password propel'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password propel'
apt-get install -y --force-yes mysql-server
echo "create database propelsandbox" | mysql -ppropel

# install Redis
apt-get install -y --force-yes redis-server

# install nginx
apt-get install -y --force-yes nginx

# configure services
cp /vagrant/configs/php.ini /etc/php5/fpm/php.ini
cp /vagrant/configs/php.ini /etc/php5/cli/php.ini
cp /vagrant/configs/php-opcache.ini /etc/php5/fpm/conf.d/05-opcache.ini

mkdir /var/www/
/vagrant/install_symfony.sh
cp /vagrant/configs/nginx-default.conf /etc/nginx/sites-available/default

# configure system
useradd sandbox --home /home/sandbox
echo 'www-data ALL= NOPASSWD: /var/www/propelsandbox/src/PropelSandbox/Resources/meta/jail.sh' >> /etc/sudoers
iptables -I OUTPUT -j REJECT -m owner --gid-owner sandbox

# restart services
service php5-fpm restart
service nginx restart

echo "Configured your sandbox.propelorm.org vagrant machined."
if [ ! -d "/vagrant/vendor" ]; then
    echo "Copying ./vendor to your machine so you have auto completion and code analysis availbe ..."
    cp -r /var/www/propelsandbox/vendor /vagrant/vendor
fi