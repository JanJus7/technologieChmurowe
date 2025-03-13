#!/bin/bash

docker compose up -d

sleep 10

response=$(curl -s http://localhost:8080)
expected='[{"_id":"652f8b7b7b7b7b7b7b7b7b7b","name":"example","__v":0}]'

if echo "$response" | grep -q "example"; then
  echo "Test passed: Server returned data from MongoDB"
else
  echo "Test failed: Server did not return the expected data"
  echo "Expected: $expected"
  echo "Received: $response"
fi

docker compose down