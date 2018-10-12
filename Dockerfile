FROM ubuntu:16.04

MAINTAINER Ivan Nemshilov

# Обвновление списка пакетов
RUN apt-get -y update

# install nginx
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y
RUN apt-get install -y nginx
# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# volume
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/var/log/nginx"]
# expose ports
EXPOSE 80 443
# add nginx conf
RUN rm /etc/nginx/conf.d/*
ADD config/default.conf /etc/nginx/conf.d/
WORKDIR /etc/nginx
CMD ["nginx"]
