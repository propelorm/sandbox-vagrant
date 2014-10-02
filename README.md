# Propel's Sandbox Vagrant

This gives you a ready-to-use version of sandbox.propelorm.org.

What you need to do:

1. Checkout this repository and `cd` into it.
2. Checkout @propelorm/sandbox into `./src` so you have `./src/PropelSandbox`.
3. Fire `vagrant up` and take a coffee, or two.
4. Fire `/var/www/propelsandbox/app/console propel:build`
5. Fire `cd /var/www/propelsandbox/src/PropelSandbox && bower install`
6. Open `http://127.0.0.1:8080/app_dev.php` in your browser.