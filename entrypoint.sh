#!/bin/sh

# Ensure default assets are present.
while true; do echo n; done | cp -Ri /usr/share/nginx/html/default-assets/* /usr/share/nginx/html/assets/ &> /dev/null

# Install default config if no one is available.
yes n | cp -i /usr/share/nginx/html/default-assets/config.yml.dist /www/assets/config.yml &> /dev/null

nginx -g 'daemon off;'
