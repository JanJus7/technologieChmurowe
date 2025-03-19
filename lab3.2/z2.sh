#!/bin/bash

CONTAINER_NAME="nginx_container"
IMAGE_NAME="nginx:latest"
CONFIG_FILE="default.conf"
HOST_PORT=8080

usage() {
    echo "Usage: $0 -c <config_file> -p <host_port>"
    exit 1
}

while getopts "c:p:" opt; do
    case "$opt" in
        c) CONFIG_FILE=$OPTARG ;;
        p) HOST_PORT=$OPTARG ;;
        *) usage ;;
    esac
done

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Błąd: Plik konfiguracyjny $CONFIG_FILE nie istnieje."
    exit 1
fi

docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$HOST_PORT:80" \
    -v "$(pwd)/$CONFIG_FILE:/etc/nginx/conf.d/default.conf" \
    "$IMAGE_NAME"

sleep 3

docker ps | grep "$CONTAINER_NAME" > /dev/null && echo "Test 1: Kontener działa - OK" || (echo "Test 1: Kontener nie działa - FAIL" && exit 1)

docker exec "$CONTAINER_NAME" ls /etc/nginx/conf.d/default.conf > /dev/null && echo "Test 2: Konfiguracja zamontowana - OK" || (echo "Test 2: Brak pliku konfiguracyjnego - FAIL" && exit 1)

curl -I http://localhost:"$HOST_PORT" 2>/dev/null | grep "200 OK" > /dev/null && echo "Test 3: Serwer odpowiada - OK" || (echo "Test 3: Brak odpowiedzi serwera - FAIL" && exit 1)

echo "Wszystkie testy zakończone sukcesem."
