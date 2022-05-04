#!/bin/bash

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
 
sudo apt-get install php7.4
sudo apt-get install php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring  php7.4-zip php7.4-fpm php7.4-intl php7.4-simplexml
 
sudo a2dismod php8.0
 
sudo a2enmod php7.4
 
sudo service apache2 restart  
 
sudo update-alternatives --set php /usr/bin/php7.4
sudo update-alternatives --set phar /usr/bin/phar7.4
sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.4
sudo update-alternatives --set phpize /usr/bin/phpize7.4
sudo update-alternatives --set php-config /usr/bin/php-config7.4

