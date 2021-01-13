#!/usr/bin/env bash

_term() {
  echo "TERM"
  exit 0
}

trap _term TERM

echo "Starting php-fpm"
/usr/sbin/php-fpm8.0 -F &
echo "Starting nginx"
/usr/sbin/nginx &

wait $!
