#!/bin/bash

VOLUME_NAME="nginx_data"
ARCHIVE_NAME="${VOLUME_NAME}_backup.tar"
ENCRYPTED_NAME="${ARCHIVE_NAME}.gpg"

MODE=$1

read -sp "🔑 Podaj hasło: " PASSWORD
echo ""

MOUNTPOINT=$(docker volume inspect --format '{{ .Mountpoint }}' "$VOLUME_NAME")

if [[ "$MODE" == "encrypt" ]]; then
    echo "📦 Tworzę archiwum $ARCHIVE_NAME z $MOUNTPOINT..."
    sudo tar -cf "$ARCHIVE_NAME" -C "$MOUNTPOINT" .

    echo "🔐 Szyfruję $ARCHIVE_NAME -> $ENCRYPTED_NAME"
    echo "$PASSWORD" | gpg --batch --yes --passphrase-fd 0 -c "$ARCHIVE_NAME"

    echo "🧹 Czyszczę tymczasowe archiwum..."
    rm "$ARCHIVE_NAME"

    echo "✅ Gotowe: $ENCRYPTED_NAME"

elif [[ "$MODE" == "decrypt" ]]; then
    echo "🔓 Odszyfrowuję $ENCRYPTED_NAME -> $ARCHIVE_NAME"
    echo "$PASSWORD" | gpg --batch --yes --passphrase-fd 0 -o "$ARCHIVE_NAME" -d "$ENCRYPTED_NAME"

    echo "📂 Rozpakowuję archiwum do tymczasowego katalogu ./restored_$VOLUME_NAME"
    mkdir -p "./restored_$VOLUME_NAME"
    tar -xf "$ARCHIVE_NAME" -C "./restored_$VOLUME_NAME"

    echo "🧹 Czyszczenie..."
    rm "$ARCHIVE_NAME"

    echo "✅ Odszyfrowano i rozpakowano do ./restored_$VOLUME_NAME"

else
    echo "❌ Użycie: $0 [encrypt|decrypt]"
    exit 1
fi
