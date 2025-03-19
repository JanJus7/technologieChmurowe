#!/bin/bash

set -e 

mkdir -p nginx_cache ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ssl/nginx.key -out ssl/nginx.crt \
    -subj "/CN=localhost" 2>/dev/null

cat <<EOL > nginx.conf
events {}

http {
    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_temp_path=off;

    server {
        listen 80;
        server_name localhost;

        location / {
            proxy_cache my_cache;
            proxy_pass http://node_app:3000;
        }
    }

    server {
        listen 443 ssl;
        server_name localhost;

        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;

        location / {
            proxy_cache my_cache;
            proxy_pass http://node_app:3000;
        }
    }
}
EOL

docker network create my_network 2>/dev/null || true

docker run -d --name node_app --network my_network -v $(pwd):/app -w /app node:14 sh -c "npm install && npm start"

sleep 10 

docker run -d --name nginx --network my_network \
    -p 8080:80 -p 8443:443 \
    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v $(pwd)/ssl:/etc/nginx/ssl:ro \
    -v $(pwd)/nginx_cache:/var/cache/nginx \
    nginx:latest

echo "Testing HTTP..."
curl -I http://localhost:8080 || echo "HTTP test failed!"

echo "Testing HTTPS..."
curl -I -k https://localhost:8443 || echo "HTTPS test failed!"

docker exec nginx nginx -s reload || echo "Nginx reload failed!"
