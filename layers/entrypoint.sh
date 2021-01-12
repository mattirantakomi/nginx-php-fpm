#!/usr/bin/env bash

start(){
    /usr/sbin/php-fpm8.0
    /usr/sbin/nginx
}

stop(){
    kill $(cat /run/php/php8.0-fpm.pid)
    kill $(cat /run/nginx.pid)
}

trap stop SIGINT SIGQUIT SIGHUP SIGTERM

start
