FROM jwilder/nginx-proxy

COPY vhost.extra/* /etc/nginx/vhost.extra/
COPY vhost.d/* /etc/nginx/vhost.d/
COPY conf.d/* /etc/nginx/conf.d/
