FROM node:20.2.0

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

EXPOSE 8083
