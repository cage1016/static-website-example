ARG BASE_IMAGE=nginx:1.20.2-alpine
FROM $BASE_IMAGE

COPY health /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY assets /usr/share/nginx/html/assets
COPY error /usr/share/nginx/html/error
COPY images /usr/share/nginx/html/images
COPY index.html /usr/share/nginx/html
