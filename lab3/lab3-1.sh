#!/bin/bash

PORT=${1:-8080}
CONTAINER_NAME="nginx_custom"
HTML_CONTENT="<h1>Witaj w serwerze Nginx!</h1>"

echo "Tworzenie kontenera Nginx na porcie $PORT..."

docker stop $CONTAINER_NAME 2>/dev/null

docker rm $CONTAINER_NAME 2>/dev/null

echo "Tworzenie tymczasowego katalogu z plikami strony..."
mkdir -p ./nginx_html

echo "$HTML_CONTENT" > ./nginx_html/index.html

docker run -d --name $CONTAINER_NAME -p $PORT:80 \
  -v "$PWD/nginx_html:/usr/share/nginx/html:ro" nginx

echo "Serwer Nginx uruchomiony. Strona dostępna na http://localhost:$PORT"

echo "Testowanie dostępu do strony..."
sleep 2

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT)
if [ "$RESPONSE" == "200" ]; then
  echo "Test zakończony pomyślnie: Serwer odpowiada poprawnie."
else
  echo "Błąd: Serwer nie odpowiada prawidłowo. Kod odpowiedzi: $RESPONSE"
  exit 1
fi

echo "Testowanie zawartości strony..."
CONTENT=$(curl -s http://localhost:$PORT)
if [[ "$CONTENT" == *"$HTML_CONTENT"* ]]; then
  echo "Test zakończony pomyślnie: Treść strony jest poprawna."
else
  echo "Błąd: Treść strony jest niepoprawna."
  exit 1
fi
