FROM php:7-apache

ARG DEBIAN_FRONTEND=noninteractive

#Install needed packages
RUN apt-get update && apt-get install -y --fix-missing \
        apt-utils \
        zlib1g-dev \
        libzip-dev zip unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        exiftool
        
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-configure exif
RUN docker-php-ext-install -j$(nproc) exif
# TODO CHECK IF REQUIRED...
# RUN docker-php-ext-enable exif

COPY . /var/www/html/
