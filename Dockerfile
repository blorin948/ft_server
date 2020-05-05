FROM debian:buster
MAINTAINER Lorin Benjamin <blorin@student.le-101.fr> 

RUN apt-get update && apt-get upgrade && apt-get -y install nginx mariadb-server mariadb-client php-mysql wget unzip php-gd php-intl php-fpm

RUN wget http://fr.wordpress.org/latest-fr_FR.tar.gz
RUN tar -xzvf latest-fr_FR.tar.gz
RUN mv wordpress /var/www/html/wordpress
RUN rm latest-fr_FR.tar.gz
RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN chmod -R 755 /var/www/html/wordpress/
RUN rm var/www/html/index.nginx-debian.html
RUN rm /var/www/html/wordpress/wp-config-sample.php

RUN	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english /var/www/html/phpmyadmin
RUN rm phpMyAdmin-5.0.1-english.tar.gz

RUN	 openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/ssl_key.key -x509 -days 365 -out /etc/ssl/certs/ssl_certificate.crt -subj "/C=FR/ST=Lyon/L=Lyon/O=42/OU=42/CN=blorin"

COPY srcs/default ./etc/nginx/sites-available/default
COPY srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY srcs/db_wordpress db_wordpress
COPY srcs/start.sh start.sh

RUN	 service mysql start && mysql -u root < db_wordpress

CMD bash start.sh
