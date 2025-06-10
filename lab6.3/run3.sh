docker run -d \
  --name frontend \
  --network frontend_network \
  -p 8080:3000 \
  frontend