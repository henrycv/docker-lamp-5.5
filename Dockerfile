##
## Name: docker-lamp-5.5
## Dockerfile to build a LAMP (PHP 5.5) and Node stack image
## Author: https://about.me/henrycv
##
FROM linode/lamp

MAINTAINER Henry Carbajal <entidad.estelar@gmail.com>

# # Setted fix to issue "debconf: unable to initialize frontend: Dialog"
# # http://askubuntu.com/questions/506158/unable-to-initialize-frontend-dialog-when-using-ssh
ENV DEBIAN_FRONTEND noninteractive

# Update sources and install packages
RUN apt-get -y update && apt-get -y install \
    # Install Git CSV
    git \
    # Install Vim text editor
    vim \
    # Install CURL tool
    curl \
    # Install Wget package for testing tasks
    wget \
    # Install PHP XSL
    php5-xsl \
    # Install PHP XMLRPC
    php5-xmlrpc \
    # Install PHP SNMP
    php5-snmp \
    # Install PSPELL
    php5-pspell \
    # Install PDO SQLITE
    php5-sqlite \
    # Install PHP MEMCACHE
    php5-memcache \
    # Install PHP GD
    php5-gd  \
    # Install PHP APC
    php-apc \
    # Install PHP CURL
    php5-curl \
    # Install PHP Mcrypt
    php5-mcrypt \
    # Install MySQL extension
    php5-mysqlnd \
    # Install PHP XDebug
    php5-xdebug \
    # Install PHP MS SQL driver
    php5-sybase \
    # Install NodeJS
    nodejs \
    # Install NPM
    npm \
    # --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove

# Enable Apache mod rewrite
RUN a2enmod rewrite

# Enable module expires.
RUN a2enmod file_cache
RUN a2enmod expires
RUN a2enmod headers
RUN a2enmod ssl

# Enable PHP Mcrypt extension
RUN php5enmod mcrypt

# Copy the customized Apache config on guest machine:
COPY ./config/apache2.conf /etc/apache2/apache2.conf
COPY ./config/ports.conf /etc/apache2/ports.conf

# Copy the customized PHP development config on guest machine:
COPY ./config/php.ini /etc/php5/apache2/php.ini

# Create the folder if it doesn't exits
RUN [ -d /usr/local/bin/ ] || mkdir -p /usr/local/bin/

# Install PHP Composer globally
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install PHP Symfony framework tool globally
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

# Install Grunt JS tool
RUN npm install -g grunt grunt-cli

# Create an alias "node" from "nodejs"
RUN ln -fs /usr/bin/nodejs /usr/bin/node

ADD start.sh start.sh
RUN chmod 777 start.sh
CMD ["/bin/bash", "-lc", "./start.sh"]
