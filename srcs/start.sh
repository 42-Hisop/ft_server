#!/bin/bash

openssl req -newkey rea:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42/OU=khee-seo/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
mv localhost.dev.crt etc/ssl/certs/
mv localhost.dev.key etc/ssl/private/
chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

cp -p /srcs_temp/default etc/nginx/sites-available
rm -f etc/nginx/sites-enabled/default

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress var/www/html
chown -R www-data:www-data var/www/html/wordpress
cp -p srcs_temp/wp-config.php var/www/html/wordpress

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'khee-seo'@'localhost' IDENTIFIED BY 'password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'khee-seo'@'localhost' WITH REANT OPTION;" | mysql -u root --skip-password

wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /var/www/html/
cp -p srcs_temp/config.inc.php var/www/html/phpmyadmin

service nginx start
service php7.3-fpm start
service mysql restart

bash
