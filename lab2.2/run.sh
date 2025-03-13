#!/bin/bash

docker build -t express-date-app .

docker run -d -p 8080:8080 --name express-date-container express-date-app

sleep 5

response=$(curl -s http://localhost:8080)
current_date=$(date -u +"%Y-%m-%dT%H:%M:%S")
current_date_JSON=$(echo "{\"date\":\"$current_date\"}")

if echo "$response" | grep -q "$current_date"; then
  echo "Test passed: Server returned current date and time"
else
  echo "Test failed: Server did not return the expected date and time"
  echo "Expected: $current_date_JSON"
  echo "Received: $response"
fi

docker stop express-date-container
docker rm express-date-container