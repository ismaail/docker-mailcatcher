FROM ruby:2-alpine

MAINTAINER ismaail <contact@ismaail.com>

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    make \
    g++ \
    sqlite-dev

RUN echo http://dl-2.alpinelinux.org/alpine/edge/main/ >> /etc/apk/repositories \
    && apk --no-cache add \
    sqlite-libs \
    ruby-dev

# Install mailcatcher
RUN gem install --no-ri --no-rdoc mailcatcher json

# Cleanup
RUN apk del .build-deps \
    && rm -rf /var/cache/apk/*

EXPOSE 1080 1025

ENTRYPOINT ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
