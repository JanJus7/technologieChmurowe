#!/bin/bash

docker volume create nginx_data

docker run --rm -v nginx_data:/usr/share/nginx/html alpine sh -c \
      "echo '<!DOCTYPE html><html><head><title>Witaj!</title></head><body><h1>Strona z wolumenu!</h1></body></html>' > /usr/share/nginx/html/index.html"

docker run -d --name my_nginx -p 8080:80 -v nginx_data:/usr/share/nginx/html nginx

echo "Nginx is running. Visit http://localhost:8080..."