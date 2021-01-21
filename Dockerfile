FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Helsinki

RUN apt-get update && apt-get install -y curl gnupg2 ca-certificates lsb-release \
    wget curl nano rsync net-tools screen dnsutils apt-transport-https \
    software-properties-common unzip wget git bc tzdata locales \
    && rm -rf /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN echo "deb http://nginx.org/packages/mainline/ubuntu focal nginx" > /etc/apt/sources.list.d/nginx.list \
    && curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update && apt-get install nginx && rm -rf /var/lib/apt/lists/*

RUN apt-get update && add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y php8.0 php8.0-bcmath php8.0-bz2 php8.0-cgi php8.0-cli \
    php8.0-common php8.0-curl php8.0-dba php8.0-enchant php8.0-fpm php8.0-gd php8.0-gmp php8.0-imap \
    php8.0-interbase php8.0-intl php8.0-ldap php8.0-mbstring php8.0-mysql php8.0-odbc php8.0-opcache \
    php8.0-pgsql php8.0-pspell php8.0-readline php8.0-snmp php8.0-soap php8.0-sqlite3 php8.0-sybase \
    php8.0-tidy php8.0-xml php8.0-xsl php8.0-zip

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /var/cache/nginx && chmod -R 777 /var/cache/nginx

COPY layers/ /

ENTRYPOINT ["/entrypoint.sh"]
