FROM php:5.6-apache
MAINTAINER Pierre Galvez <pierre@lbab.fr>

RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers

# Update package list before installing ones
RUN apt-get update && apt-get install -y locales
    && dpkg-reconfigure locales \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8

CMD ["apache2-foreground"]
