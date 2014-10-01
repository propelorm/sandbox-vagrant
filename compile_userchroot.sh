#!/bin/sh


cd /vagrant/src/PropelSandbox/Resources/meta/userchroot-0.1/
gcc userchroot.c
mv a.out /usr/bin/userchroot
chown root:root /usr/bin/userchroot
chmod u+s /usr/bin/userchroot