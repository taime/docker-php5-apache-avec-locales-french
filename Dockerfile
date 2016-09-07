FROM php:5.6-apache
MAINTAINER Art Rowan <art@rownarts.com>

RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers

# Update package list before installing ones
RUN apt-get update && apt-get install -y locales \
    && rm -rf /var/lib/apt/lists/*
RUN dpkg-reconfigure locales \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_FR.UTF-8

ADD ./config/php.ini /usr/local/etc/php/

CMD ["apache2-foreground"]
