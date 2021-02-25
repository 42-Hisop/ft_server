FROM debian:buster

RUN apt-get update && apt-get install -y vim \
	wget \
	nginx \
	openssl \
	php7.3-fpm \
	php-mysql \
	php-mbstring \
	mariadb-server \

COPY ./srcs/start.sh ./
COPY ./srcs/default ./srcs_temp
COPY ./srcs/wp-config.php ./srcs_temp
COPY ./srcs/config.inc.php ./srcs_temp

EXPOSE 80 443

CMD bash start.sh
