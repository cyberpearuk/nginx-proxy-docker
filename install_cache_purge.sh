#! /bin/bash
set -e

CACHE_PURGE_VERSION=2.4.1
NGINX_VERSION=`nginx -V 2>&1 | grep "nginx version" | awk -F/ '{ print $2}'`     
BASE_CONFIGURE_ARGS=`nginx -V 2>&1 | grep "configure arguments" | cut -d " " -f 3-`

# Install build tools
apt-get update     
apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential \
    libssl-dev \
    libpcre3-dev \
    zlib1g-dev     
apt-get clean
rm -rf /var/lib/apt/lists/*

# Download source
cd /tmp     

wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xf nginx-${NGINX_VERSION}.tar.gz     
mv nginx-${NGINX_VERSION} nginx
rm nginx-${NGINX_VERSION}.tar.gz

wget https://github.com/nginx-modules/ngx_cache_purge/archive/${CACHE_PURGE_VERSION}.tar.gz \
     -O ngx_cache_purge-${CACHE_PURGE_VERSION}.tar.gz
tar -xf ngx_cache_purge-${CACHE_PURGE_VERSION}.tar.gz
mv ngx_cache_purge-${CACHE_PURGE_VERSION} ngx_cache_purge
rm ngx_cache_purge-${CACHE_PURGE_VERSION}.tar.gz

# Recompile nginx with ngx_cache_purge modue
cd /tmp/nginx
/bin/sh -c "./configure ${BASE_CONFIGURE_ARGS} --add-module=/tmp/ngx_cache_purge"
make
make install
rm -rf /tmp/nginx*  
