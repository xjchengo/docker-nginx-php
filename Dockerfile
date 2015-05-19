FROM php:fpm

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.0-1~jessie

COPY sources.list /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y ca-certificates \
        nginx=${NGINX_VERSION} \
        supervisor && \
    rm -rf /var/lib/apt/lists/*

RUN touch /etc/supervisor/conf.d/supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 22
CMD ["supervisord"]