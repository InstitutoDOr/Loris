FROM ubuntu:18.04
LABEL author="Bruno Melo <bruno.melo@idor.org>"

ENV DEBIAN_FRONTEND=noninteractive
ARG LORIS_VERSION=v20.0.1
# Stock images come without apt archive -- needs an update
RUN apt-get -qqq update

# APACHE
RUN apt-get install software-properties-common -y && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update -y
RUN apt-get -y install apache2 curl git zip wget mysql-client iproute2
RUN a2enmod rewrite

# PHP & COMPOSER
RUN apt-get -y install php7.2 php7.2-cli php7.2-json php7.2-mysql php7.2-xml php7.2-zip php7.2-mbstring php7.2-gd libapache2-mod-php7.2
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
RUN a2enmod php7.2

COPY docs/config/apache2-site /etc/apache2/sites-available/loris.conf
RUN sed -i -e "s#%LORISROOT%#/var/www/loris/#g" \
        -e "s#%PROJECTNAME%#loris#g" \
        -e "s#%LOGDIRECTORY%#/var/log/apache2/#g" \
        /etc/apache2/sites-available/loris.conf
RUN a2dissite 000-default
RUN ls /etc/apache2/sites-available
RUN ls /etc/apache2/sites-enabled
RUN a2ensite loris

EXPOSE 80

RUN mkdir /var/www/loris
WORKDIR /var/www/loris
VOLUME [ "/var/www/loris" ]

COPY docs/Docker/LorisWeb-EntryPoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["apache2ctl", "-D", "FOREGROUND"]
ENTRYPOINT ["/entrypoint.sh"]