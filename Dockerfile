FROM php:8.2.12-fpm

LABEL maintainer="Aurimas Kuniutis"

# RUN apt update && apt install -y \
#     supervisor

#-------------------------------------------------------------------------------------------------
# Add composer binaries
#-------------------------------------------------------------------------------------------------
COPY --from=composer /usr/bin/composer /usr/bin/composer

#-------------------------------------------------------------------------------------------------
# Install dependencies
#-------------------------------------------------------------------------------------------------
RUN apt update && apt install -y \
    git

#-------------------------------------------------------------------------------------------------
# Install and manage php extentions
#-------------------------------------------------------------------------------------------------
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
    opentelemetry-php/ext-opentelemetry@main

# RUN docker-php-ext-install \
#     opentelemetry-php/ext-opentelemetry@main

#-------------------------------------------------------------------------------------------------
# Add and use non root user
# https://stackoverflow.com/questions/27701930/how-to-add-users-to-docker-container
#-------------------------------------------------------------------------------------------------
RUN useradd \
    --create-home \
    --shell /bin/bash \
    --groups www-data \
    app

USER app

# COPY start-container /usr/local/bin/start-container
# COPY etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# COPY etc/php/php.ini $PHP_INI_DIR/php.ini
# RUN chmod +x /usr/local/bin/start-container

CMD [ "php-fpm" ]

# ENTRYPOINT [ "start-container" ]