FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y apache2 wget less htop git php-fpm zip mysql-server

RUN apt-get install -y nodejs


