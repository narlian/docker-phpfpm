FROM ubuntu:xenial
MAINTAINER romeOz <serggalka@gmail.com>

ENV OS_LOCALE="en_US.UTF-8"
RUN apt-get update \
    && apt-get install -y locales \
    && echo "LANGUAGE=${OS_LOCALE}" > /etc/default/locale \
    && echo "LC_ALL=${OS_LOCALE}" >> /etc/default/locale \
    && echo "LANG=${OS_LOCALE}" >> /etc/default/locale \
    && echo "LC_TYPE=${OS_LOCALE}" >> /etc/default/locale \
#    && echo "LC_ALL=${OS_LOCALE}" >> /etc/environment \
#    && echo "${OS_LOCALE} UTF-8" >> /etc/locale.gen \
#    && echo "LANG=${OS_LOCALE}" > /etc/locale.conf \
    && locale-gen ${OS_LOCALE}

ENV LANG=${OS_LOCALE} \
#    LANGUAGE=en_US:en \
#    LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive

ENV PHP_RUN_DIR=/run/php \
    PHP_LOG_DIR=/var/log/php \
    PHP_CONF_DIR=/etc/php/7.2 \
    PHP_DATA_DIR=/var/lib/php

RUN \
    buildDeps='software-properties-common python-software-properties' \
    && dpkg-reconfigure locales \
    # Install common libraries
    && apt-get install --no-install-recommends -y $buildDeps \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    # Install PHP libraries
    # php7.2-mcrypt not support and move to PECL. Use extension Sodium: http://php.net/manual/book.sodium.php
    && apt-get install -y curl php7.2-fpm php7.2-cli php7.2-readline php7.2-mbstring php7.2-zip php7.2-intl php7.2-json php7.2-xml php7.2-curl php7.2-gd php7.2-pgsql php7.2-mysql php-pear \
    #&& phpenmod mcrypt \
    # Install composer
    && curl -sS https://getcomposer.org/installer | php -- --version=1.6.2 --install-dir=/usr/local/bin --filename=composer \
    && mkdir -p ${PHP_LOG_DIR} ${PHP_RUN_DIR} \
    # Cleaning
    && apt-get purge -y --auto-remove $buildDeps locales \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./configs/php-fpm.conf ${PHP_CONF_DIR}/fpm/php-fpm.conf
COPY ./configs/www.conf ${PHP_CONF_DIR}/fpm/pool.d/www.conf
COPY ./configs/php.ini ${PHP_CONF_DIR}/fpm/conf.d/custom.ini

RUN sed -i "s~PHP_RUN_DIR~${PHP_RUN_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
    && sed -i "s~PHP_LOG_DIR~${PHP_LOG_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
    && chown www-data:www-data ${PHP_DATA_DIR} -Rf

WORKDIR /var/www

EXPOSE 9000

# PHP_DATA_DIR store sessions
VOLUME ["${PHP_RUN_DIR}", "${PHP_DATA_DIR}"]
CMD ["/usr/sbin/php-fpm7.2"]