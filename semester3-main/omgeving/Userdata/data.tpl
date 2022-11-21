#!/bin/bash

sudo apt update && apt upgrade -y
sudo apt-get install apache2 -y
sudo apt-get install php php-cli php-fpm php-mysql php-json php-opcache php-mbstring php-xml php-gd php-curl -y
sudo apt-get install cifs-utils -y

cd /tmp && sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvf latest.tar.gz


echo -e "
<?php
define('DB_NAME', '${dbname}');
define('DB_USER', '${dbuser}');
define('DB_PASSWORD', '${dbpassword}');
define('DB_HOST', '${dbadres}');
\$table_prefix = 'wp_';
if ( ! defined( 'ABSPATH' ) ) {
  define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
?>
" >> /tmp/wp-config.php


sudo mkdir /etc/smbcredentials
sudo chmod 777 /etc/smbcredentials
sudo echo username=${Storageaccountname} >> /etc/smbcredentials/${Storageaccountname}.cred
sudo echo password=${Storageaccountkey} >> /etc/smbcredentials/${Storageaccountname}.cred
sudo chmod 600 /etc/smbcredentials/${Storageaccountname}.cred

sudo mount -t cifs //${Storageaccountname}.file.core.windows.net/${Filesharename} /var/www/ -o credentials=/etc/smbcredentials/${Storageaccountname}.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30
cd /tmp
sudo cp -R wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/
sudo mkdir /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/
sudo cp /tmp/wp-config.php /var/www/html/wp-config.php
cd /var/www/html
sudo rm -r wordpress
sudo rm index.html
sudo systemctl apache2 restart