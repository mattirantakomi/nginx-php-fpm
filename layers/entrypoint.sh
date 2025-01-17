#!/usr/bin/env bash

_term() {
  echo "TERM"
  echo "Killing php-fpm"
  kill $(cat /run/php8.3-fpm.pid)
  echo "Killing nginx"
  /usr/sbin/nginx -s stop
  exit 0
}

trap _term TERM

echo "Starting php-fpm"
/usr/sbin/php-fpm8.3 -F &
echo "Starting nginx"
/usr/sbin/nginx &

wait $!
