FROM ubuntu:16.04

MAINTAINER Ivan Nemshilov

# install nginx
RUN apt-get update \
    && apt-get install -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists
# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# volume
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/var/log/nginx"]
# expose ports
EXPOSE 80 443
# add nginx conf
ADD config/default.conf /etc/nginx/conf.d/
RUN systemctl restart nginx
WORKDIR /etc/nginx
CMD ["nginx"]
