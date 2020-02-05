FROM php:7-apache

ARG DEBIAN_FRONTEND=noninteractive

#Install needed packages
RUN apt-get update && apt-get install -y --fix-missing \
        vim-tiny \
        rsync \
        apt-utils \
        zlib1g-dev \
        libzip-dev zip unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        exiftool

ENV DEFAULT_PATH="uploads/"
ENV PRIVATE_PATH="private/"
ENV SECURITY_STRING="aQw1zSx2eDc3rFv4"
ENV UPLOAD_MAX_FILESIZE="20GB"
        
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-configure exif
RUN docker-php-ext-install -j$(nproc) exif
# TODO CHECK IF REQUIRED...
# RUN docker-php-ext-enable exif

COPY --chown=www-data:www-data . /var/www/html/
COPY sync /usr/bin
RUN chmod +x /usr/bin/sync

VOLUME /html
EXPOSE 80


