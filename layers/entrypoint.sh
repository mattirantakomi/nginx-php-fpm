#!/usr/bin/env bash

start(){
    /usr/sbin/php-fpm8.0
    /usr/sbin/nginx
}

stop(){
    /usr/sbin/nginx -s stop
    kill $(cat /run/php8.0-fpm.pid)
    sleep 5
    kill -9 $(cat /run/php8.0-fpm.pid)
}

trap stop SIGINT SIGQUIT SIGHUP SIGTERM

start
