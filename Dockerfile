#   Objectives:
    ##  1. Install Apache and php 7
    ##  2. Install Component and php extensions
    ##  3. Install Composer
    ##  4. Add User ktle-admin


##  1. Install Apache and php 7
# This Docker Image instantiate from phusion/baseimage:0.10.0 Image
# phusion/baseimage:0.10.0 is a light version of Ubuntu 16.04 with PHP 5.6 installed
FROM alexcheng/apache2-php7


##  2. Install Component and php extensions
RUN requirements="libpng12-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg-turbo8 libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libxslt1-dev" && \
    apt-get update && \
    apt-get install -y $requirements && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    docker-php-ext-install intl && \
    docker-php-ext-install xsl && \
    docker-php-ext-install soap && \
    docker-php-ext-install bcmath && \
    requirementsToRemove="libpng12-dev libmcrypt-dev libcurl3-dev libpng12-dev libfreetype6-dev libjpeg-turbo8-dev" && \
    apt-get purge --auto-remove -y $requirementsToRemove && \
# a2enmod rewrite
    a2enmod rewrite && \
# Install Tools
    apt-get update && \
    apt-get install -y \
    nano \
    vim \
    telnet \
    netcat \
    git-core \
    zip && \
    apt-get purge -y --auto-remove && \ 
    rm -rf /var/lib/apt/lists/*
RUN apt update && \
    apt install -y nmap && \
# Update and Remove
    apt-get update -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \ 
    rm -rf /var/lib/apt/lists/* && \
#   Install SSHD KEY
    /usr/bin/ssh-keygen -A && \
##  3. Install 'Composer'
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin && \
##  Install Magerun/n98-magerun2
    #curl -sS  https://files.magerun.net/n98-magerun2-latest.phar -o /usr/local/bin/magerun && chmod +x /usr/local/bin/magerun && \
##  Install Modman
    curl -sS https://raw.github.com/colinmollenhour/modman/master/modman-installer -o /usr/local/bin/modman && chmod +x /usr/local/bin/modman
##  4. Add User ktle-admin
COPY files/n98-magerun2.phar /usr/local/bin/magerun
COPY files/modman /usr/local/bin/modman
COPY files/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY files/php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh  /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
WORKDIR /var/www/html


## Docker image name:                           apache-php-7-magento2-environment
## Docker Hub image name:                       devtutspace/apache-php-7-magento2-environment
## Build command:                               docker build -t apache-php-7-magento2-environment ./
## Build Command No Cache:                      docker build --no-cache -t apache-php-7-magento2-environment ./
## Docker Image Tag command:                    docker tag apache-php-7-magento2-environment devtutspace/apache-php-7-magento2-environment
## Docker Image Push command:                   docker push devtutspace/apache-php-7-magento2-environment
## Docker Image Build, Tag, Push:               docker build -t apache-php-7-magento2-environment ./ && docker tag apache-php-7-magento2-environment devtutspace/apache-php-7-magento2-environment && docker push devtutspace/apache-php-7-magento2-environment
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t apache-php-7-magento2-environment ./ && docker tag apache-php-7-magento2-environment devtutspace/apache-php-7-magento2-environment && docker push devtutspace/apache-php-7-magento2-environment