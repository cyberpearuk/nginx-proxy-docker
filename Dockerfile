FROM jwilder/nginx-proxy

# Install 3rd Party cache purge module https://github.com/nginx-modules/ngx_cache_purge
# Adds ability to purge content proxy cache with the "proxy_cache_purge" directive
COPY install_cache_purge.sh ./
RUN ./install_cache_purge.sh

COPY vhost.extra/* /etc/nginx/vhost.extra/
COPY vhost.d/* /etc/nginx/vhost.d/
COPY conf.d/* /etc/nginx/conf.d/


# Allow cache to persist across restarts
VOLUME /var/cache/nginx


