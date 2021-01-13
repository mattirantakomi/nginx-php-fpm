#!/usr/bin/env bash

_start(){
    echo "Starting php-fpm"
    /usr/sbin/php-fpm8.0
    echo "Starting nginx"
    /usr/sbin/nginx
}

_stop(){
    echo "Stopping nginx"
    /usr/sbin/nginx -s stop
    echo "Stopping php-fpm"
    kill $(cat /run/php8.0-fpm.pid)
    sleep 5
    echo "Killing php-fpm"
    kill -9 $(cat /run/php8.0-fpm.pid)
    exit 0
}

trap _stop TERM HUP INT QUIT USR1 USR2

_start
