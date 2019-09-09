FROM php:7.1.27-apache-jessie

LABEL maintainer="Histelen"

RUN mkdir -p /var/www/myapp/public
COPY .docker/php/php.ini /usr/local/etc/php/
COPY .docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY .docker/php/xdebug-dev.ini /usr/local/etc/php/conf.d/xdebug-dev.ini

RUN docker-php-ext-install pdo pdo_mysql mysqli && \
    docker-php-ext-install opcache

RUN pecl install xdebug-2.5.1
RUN docker-php-ext-enable xdebug
RUN a2enmod rewrite negotiation

#Install GIT, GnuPG, NodeJS and NPM
RUN apt-get update && apt-get install -y git gnupg && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

#Add Laravel necessary php extensions
RUN apt-get install -y \
    unzip \
    vim \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev

# Create working directory
RUN mkdir -p /var/www/myapp
ENV APACHE_DOCUMENT_ROOT /var/www/myapp/public
ENV APP_NAME "myapp"

# Install composer from image. You may change it to the latest
COPY --from=composer:1.5 /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/myapp

# Make laravel feel comfortable with mod-rewrite
RUN a2enmod rewrite && service apache2 restart
EXPOSE 80


ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /srv/app
