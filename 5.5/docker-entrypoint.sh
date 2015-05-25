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

    case "${FRAMEWORK,,}" in

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

if [ -n "$MYSQL_ROOT_PASSWORD" ] || [ -n "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
    if [ -z "$DB_HOST" ]; then
        DB_HOST='mysql'
        DB_PORT='3306'
        DB_USER='root'
        if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
            DB_PASSWORD="$MYSQL_ROOT_PASSWORD"
        else
            DB_PASSWORD=''
        fi
    else
        echo >&2 'warning: both DB_HOST and linked mysql container found'
        echo >&2 "  Remove one please"
        exit 1
    fi
fi

if [ -z "$DB_HOST" ]; then
    echo >&2 'error: missing DB_HOST environment variables'
    echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
    echo >&2 '  with -e DB_HOST=hostname -e DB_PORT=port?'
    # to do remove redir and socat command in supervisord.conf
else
    if [ -z "$DB_PORT" ]; then
        DB_PORT='3306'
    fi
    sed -i "s/DB_PORT/$DB_PORT/" /etc/supervisor/conf.d/supervisord.conf
    sed -i "s/DB_HOST/$DB_HOST/" /etc/supervisor/conf.d/supervisord.conf

    if [ -z "$DB_USER" ]; then
        DB_PORT='root'
    fi
    if [ -z "$DB_PASSWORD" ]; then
        DB_PASSWORD=''
    fi

    # create initial database
    if [ -n "$DB_NAME" ]; then
        alauda db:create -p $DB_PORT $DB_NAME $DB_HOST $DB_USER $DB_PASSWORD
    fi

fi


exec "$@"
