# Dockerfile
FROM php:8.2-fpm

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install intl pdo pdo_mysql zip gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers du projet dans le conteneur
WORKDIR /var/www/html
COPY . .

# Installer les dépendances PHP du projet
RUN composer install

# Donner les droits à l'utilisateur www-data
RUN chown -R www-data:www-data /var/www/html

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000
