#!/bin/bash

docker build -t node-hello-world .

docker run -d -p 8080:8080 --name node-hello-world-container node-hello-world

sleep 5

response=$(curl -s http://localhost:8080)

if [ "$response" == "Hello World" ]; then
  echo "Test passed: Server returned 'Hello World'"
else
  echo "Test failed: Server did not return 'Hello World'"
fi

docker stop node-hello-world-container
docker rm node-hello-world-container