FROM php:8.1-fpm

# Symfony 1 method
#RUN curl -1Lf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
#RUN apt-get update && apt-get install -y symfony-cli
# Symfony 2 method
#RUN curl -sS https://get.symfony.com/cli/installer | bash
#RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

RUN apt-get update && apt-get install -y \
    git \
    zip \
    dnsutils \
    iputils-ping \
    libpq-dev \
    libicu-dev \
    librabbitmq-dev \
    libmagickwand-dev
RUN git config --global user.email "sergeisvirin72@gmail.com" && \
    git config --global user.name "Sergei Svirin"
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    intl
RUN pecl install \
    ds \
    amqp \
    imagick \
    xdebug \
    redis \
    && docker-php-ext-enable \
    ds \
    amqp \
    imagick \
    xdebug \
    redis
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN echo "export PATH=\"$PATH:$HOME/.composer/vendor/bin\"\n" >> "$HOME/.bashrc"
RUN composer global require friendsofphp/php-cs-fixer
COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
WORKDIR /app
EXPOSE 8080
#ENTRYPOINT ["/bin/bash", "./bootstrap.sh"]
