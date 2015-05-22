#!/bin/bash
set -e

if [ -z "$ROOT_PASSWORD" ]; then
	echo >&2 'error: set ROOT_PASSWORD please'
	exit 1
fi

# set root password and make root loginable
echo "root:$ROOT_PASSWORD" | chpasswd
mkdir -p /var/run/sshd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile


if [ -z "$FRAMEWORK" ]; then
    export FRAMEWORK=laravel
fi

if [ "$FRAMEWORK" = "reverse_proxy" ]; then
    cat /root/server_config/reverse_proxy/nginx.conf > /etc/nginx/conf.d/default.conf
else
    # git clone
    if [ -z "$REPOSITORY_URL" ]; then
        # todo: check repository url start with https

        echo >&2 'error: set REPOSITORY_URL please'
        exit 1
    fi
    cd /var/www && git clone "$REPOSITORY_URL" web

    # install project dependency
    cd /var/www/web && composer install --no-scripts --no-interaction && composer run-script --no-interaction post-create-project-cmd

    chown -R www-data:www-data /var/www/web

    case "$FRAMEWORK" in

        'laravel')
            echo 'use laravel config'
            cat /root/server_config/laravel/nginx.conf > /etc/nginx/conf.d/default.conf
            ;;

        'thinkphp')
            echo 'use thinkphp config'
            cat /root/server_config/thinkphp/nginx.conf > /etc/nginx/conf.d/default.conf
            ;;
    esac

fi

exec "$@"
