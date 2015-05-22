FROM php:fpm
MAINTAINER xjchengo

COPY sources.list /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.0-1~jessie

# install utils
RUN apt-get update && \
    apt-get install -y ca-certificates \
        curl \
        git \
        nginx=${NGINX_VERSION} \
        openssh-server \
        supervisor \
        unzip \
        vim && \
    rm -rf /var/lib/apt/lists/*

# install php modules
RUN apt-get update && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY config /root/server_config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www
EXPOSE 80 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]
