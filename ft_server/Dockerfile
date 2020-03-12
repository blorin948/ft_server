FROM debian:buster
MAINTAINER Lorin Benjamin <blorin@student.le-101.fr> 

RUN apt-get update && apt-get upgrade && apt-get -y install nginx mariadb-server mariadb-client php-mysql wget unzip php-gd php-intl php-fpm

COPY src/init.sql ./
#COPY src/config-local-nginx ./root/

#RUN rm /etc/nginx/sites-available/default
COPY src/default /etc/nginx/sites-available/

COPY src/wordpress /etc/nginx/sites-available/
COPY src/phpmyadmin /etc/nginx/sites-available/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
		tar -xzvf phpMyAdmin-5.0.1-english.tar.gz && \
		mv phpMyAdmin-5.0.1-english /var/www/html/phpmyadmin && \
		rm phpMyAdmin-5.0.1-english.tar.gz

RUN wget http://fr.wordpress.org/latest-fr_FR.tar.gz
RUN tar -xzvf latest-fr_FR.tar.gz
RUN mv wordpress /var/www/html
RUN rm latest-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN chmod -R 755 /var/www/html/wordpress/

RUN		openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/ssl_key.key \
		-x509 -days 365 -out /etc/ssl/certs/ssl_certificate.crt \
		-subj "/C=FR/ST=Lyon/L=Lyon/O=42/OU=42/CN=blorin"

RUN cd var/www/html && ls

#COPY src/index.html /var/

#COPY srcs/wp-config.php /var/www/html/wordpress

RUN rm /var/www/html/index.nginx-debian.html

RUN cd var/www/html && ls

#COPY src/index.html /var/www/html
#RUN service mysql start && mysql -uroot -proot mysql < "./init.sql"
COPY src/wp-config.php /var/www/html/wordpress
RUN cd /var/www/html && ls 


#RUN ln -s /etc/nginx/sites-available/html /etc/nginx/sites-enabled/html
#RUN cd /var/www
#RUN mkdir html
#COPY src/index.php /var/www/html


EXPOSE 80 443

RUN service mysql start && mysql -u root < init.sql

CMD service nginx start && service mysql restart && service php7.3-fpm start && service --status-all && sleep infinity 
