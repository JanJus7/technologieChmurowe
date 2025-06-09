#!/bin/bash

docker volume create nodejs_data

docker run --rm -v nodejs_data:/app alpine sh -c \
        "echo 'console.log(\"Hello from NodeJS volume!\")' > /app/index.js"

docker run -d --name my_node -v nodejs_data:/app node:alpine tail -f /dev/null

docker volume create all_volumes

docker run --rm \
        -v nginx_data:/nginx_html \
        -v nodejs_data:/node_app \
        -v all_volumes:/merged \
        alpine sh -c "\
        mkdir -p /merged/nginx && cp -r /nginx_html/. /merged/nginx/ && \
        mkdir -p /merged/app && cp -r /node_app/* /merged/app/"

echo "done"