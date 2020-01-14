# Docker NGINX Proxy with Caching


## Purging Cache

```bash
curl -X PURGE -D - "https://www.example.com/*"
```

## Notes:

For existing setups, will need volumes for /etc/nginx/vhost.d to be removed (or updated to match those defined in this image) 
in order for caching to take effect.

Won't work if the upstream updates cookies each time - e.g. when using XDebug (a dev image) upstream.

Shouldn't cache content when users are logged in.



