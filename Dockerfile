# This Dockerfile is for the PHP plugin/theme development environment/tooling
# Source: https://dev.to/prazolrupakheti/how-to-set-up-wordpress-with-docker-and-wp-cli-4ghe
FROM ubuntu:22.04
LABEL name="Prazol Rupakheti"
ENV DEBIAN_FRONTEND=noninteractive

# setup a user on the container that mirrors the user on the host (to allow bind volumes)
RUN mkdir "/home/dev-user"
ENV HOME /home/dev-user

RUN useradd dev-user -u 1000 && echo 'dev-user:docker' | chpasswd
RUN echo "dev-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN chown -R 1000:1000 $HOME

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get -y install wget zip unzip curl gnupg nano cron && \
    apt-get install lsb-release ca-certificates apt-transport-https software-properties-common -y

# Install Node.js, and Apache with PHP 8
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Give ownership of the NPM cache to the dev-user, otherwise npm commands will fail
RUN chown -R 1000:1000 $HOME/.npm -R

# This repository only includes support for recent versions of Ubuntu; if it starts failing bump the ubuntu version
RUN add-apt-repository ppa:ondrej/php -y && apt update && \
    apt-get -y install php8.2 apache2 libapache2-mod-php8.2 php8.2-cli php8.2-mysql php8.2-zip php8.2-gd \
      php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath php8.2-imagick php8.2-intl mysql-client && \
    a2enmod rewrite headers expires

# Install Composer
RUN wget -q https://getcomposer.org/download/latest-stable/composer.phar && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp