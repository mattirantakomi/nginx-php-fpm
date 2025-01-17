FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Helsinki

RUN userdel -r ubuntu

RUN apt-get update && apt-get install -y curl gnupg2 ca-certificates lsb-release \
    wget curl nano rsync net-tools screen dnsutils apt-transport-https tini \
    software-properties-common unzip wget git bc tzdata locales mysql-client nginx-full \
    && rm -rf /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y php8.3 php8.3-bcmath php8.3-bz2 php8.3-cgi php8.3-cli \
    php8.3-common php8.3-curl php8.3-dba php8.3-fpm php8.3-gd php8.3-gmp php8.3-gnupg \
    php8.3-igbinary php8.3-imagick php8.3-imap php8.3-intl php8.3-libvirt-php php8.3-mailparse \
    php8.3-maxminddb php8.3-mbstring php8.3-mcrypt php8.3-memcache php8.3-memcached php8.3-msgpack \
    php8.3-mysql php8.3-oauth php8.3-odbc php8.3-opcache php8.3-ps php8.3-pspell php8.3-psr \
    php8.3-readline php8.3-redis php8.3-rrd php8.3-soap php8.3-sqlite3 php8.3-ssh2 php8.3-stomp php8.3-tideways \
    php8.3-tidy php8.3-uopz php8.3-uploadprogress php8.3-uuid php8.3-xdebug php8.3-xml php8.3-xmlrpc \
    php8.3-xsl php8.3-yaml php8.3-zip php8.3-zmq && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /var/cache/nginx /run /var/run && chmod -R 777 /var/cache/nginx /run /var/run

RUN userdel www-data && rm -rf /var/www && useradd -d /var/www -m -s /bin/bash -U -u 1000 www-data

COPY layers/ /

ENTRYPOINT ["/entrypoint.sh"]