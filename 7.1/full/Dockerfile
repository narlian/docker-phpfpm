FROM romeoz/docker-phpfpm:7.1
MAINTAINER romeOz <serggalka@gmail.com>

ENV PHP_CONF_DIR=/etc/php/7.1

RUN \
    VERSION_PECL_COUCHBASE="2.2.0beta3" && BUILD_DEPS='php7.1-dev wget' \
    && apt-get update \
    && apt-get install -y ${BUILD_DEPS} \
    && echo "deb http://packages.couchbase.com/ubuntu trusty trusty/main" | tee -a /etc/apt/sources.list.d/couchbase.list \
    && wget -O- http://packages.couchbase.com/ubuntu/couchbase.key | apt-key add - \
    && apt-get update \
    && apt-get install -y libcouchbase2-libevent libcouchbase-dev php-xdebug php-apcu php-redis php-memcache php-memcached php-mongodb php7.1-bcmath \
    && echo "apc.enable_cli=1" >> ${PHP_CONF_DIR}/mods-available/apcu.ini \
    && pecl channel-update pecl.php.net \
    # Install couchbase
    && echo "\nInstall couchbase extension\n" \
    && apt-get install -y re2c \
    && pecl install -f pcs \
    && echo "extension = pcs.so" >> ${PHP_CONF_DIR}/fpm/conf.d/pcs.ini \
    && echo "extension = pcs.so" >> ${PHP_CONF_DIR}/cli/conf.d/pcs.ini \
    && pecl install -f couchbase \
    && echo "extension = couchbase.so" >> ${PHP_CONF_DIR}/fpm/conf.d/couchbase.ini \
    && echo "extension = couchbase.so" >> ${PHP_CONF_DIR}/cli/conf.d/couchbase.ini \
    && composer global require "phpunit/phpunit:^6.0.0" \
    && echo -e '\ninclude_path = ".:/usr/share/php:/root/.composer/vendor/phpunit"' >> ${PHP_CONF_DIR}/cli/conf.d/custom.ini \
    && ln -s /root/.composer/vendor/bin/phpunit /usr/bin/phpunit \
    # Cleaning
    && apt-get purge -y --auto-remove ${BUILD_DEPS} \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /root/.composer/vendor/bin:$PATH

COPY xdebug.ini ${PHP_CONF_DIR}/mods-available/xdebug.ini

