#!/usr/bin/env bash

start(){
    /usr/sbin/php-fpm8.0
    /usr/sbin/nginx
}

stop(){
    echo "Stopping nginx"
    /usr/sbin/nginx -s stop
    echo "Stopping php-fpm"
    kill $(cat /run/php8.0-fpm.pid)
    sleep 5
    echo "Killing php-fpm"
    kill -9 $(cat /run/php8.0-fpm.pid)
    exit 0
}

trap "echo TERM" TERM
trap "echo HUP" HUP
trap "echo INT" INT
trap "echo QUIT" QUIT
trap "echo USR1" USR1
trap "echo USR2" USR2

trap stop TERM HUP INT QUIT USR1 USR2

start
