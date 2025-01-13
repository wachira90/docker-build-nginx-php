# docker-build-nginx-php
docker-build-nginx-php


FROM php:7.4-fpm
RUN docker-php-ext-install mysqli
EXPOSE 9000


application/config/config.php
application/views/include/fb_px.php

