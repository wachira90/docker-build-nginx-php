# Start with the PHP-FPM base image
FROM php:7.4-fpm

# Install Nginx and other necessary packages
RUN apt-get update && apt-get install -y \
    nginx \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mbstring zip opcache mysqli \
    && docker-php-ext-enable opcache

ENV TZ="Asia/Bangkok"

# Set up Nginx
RUN mkdir -p /run/nginx

# Copy the Nginx configuration file
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy application files
WORKDIR /var/www/html
# COPY . .
COPY index.php .

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose ports for Nginx and PHP-FPM
EXPOSE 80

# Start both PHP-FPM and Nginx
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
