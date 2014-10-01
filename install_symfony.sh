#!/bin/sh

cd /var/www/

if [ -d /var/www/propelsandbox/ ]; then
    echo "propelsandbox already installed.";
    exit
fi

VERSION="v2.5.5"
wget --no-check-certificate https://github.com/symfony/symfony-standard/archive/$VERSION.tar.gz
curl -s https://getcomposer.org/installer | php

tar xf $VERSION.tar.gz
mv symfony-standard-* propelsandbox

rm -rf /var/www/propelsandbox/src
mkdir /vagrant/src

ln -s /vagrant/src /var/www/propelsandbox/src

cp /vagrant/configs/AppKernel.php propelsandbox/app/AppKernel.php
cp /vagrant/configs/routing.yml propelsandbox/app/config/routing.yml
cp /vagrant/configs/config.yml propelsandbox/app/config/config.yml
cp /vagrant/configs/parameter.yml propelsandbox/app/config/parameter.yml
cp /vagrant/configs/composer.json propelsandbox/composer.json

cd propelsandbox

../composer.phar update --prefer-dist
../composer.phar dump-autoload --optimize

rm -r /vagrant/vendor
cp -r ./vendor /vagrant/vendor

chown -R www-data:www-data .