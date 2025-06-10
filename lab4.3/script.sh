#!/bin/bash


for volume in $(docker volume ls -q); do
  echo "$volume"
  docker run --rm -v ${volume}:/data alpine sh -c "du -sh /data || echo brak danych"
  echo ""
done
