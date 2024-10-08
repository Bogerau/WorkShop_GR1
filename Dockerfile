# Étape 1 : Construction de l'image PHP avec Symfony
FROM php:8.2-fpm

# Installer les dépendances PHP
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install intl opcache pdo pdo_mysql zip gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer Node.js et npm
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

# Créer le répertoire de l'application
WORKDIR /var/www/html

# Copier les fichiers du projet
COPY . .

# Installer les dépendances PHP
RUN composer install --no-scripts --no-interaction --optimize-autoloader

# Installer les dépendances npm
RUN npm install

# Compiler les assets avec Webpack Encore
RUN chown -R www-data:www-data /var/www/html/public/build
RUN npm run build

# Exposer le port de l'application
EXPOSE 9000

CMD ["php-fpm"]
