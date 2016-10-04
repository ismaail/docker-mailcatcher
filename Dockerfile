FROM ubuntu:16.04

MAINTAINER ismaail <contact@ismaail.com>

RUN apt-get update \
  && apt-get install -q -y \
    libsqlite3-dev \
    ruby2.3 \
    ruby2.3-dev \
    build-essential \
  && gem install --no-ri --no-rdoc mailcatcher json \
  && apt-get remove -y build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

EXPOSE 1080 1025

ENTRYPOINT ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]

