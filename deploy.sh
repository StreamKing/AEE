#!/bin/bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "Fehler: .env Datei nicht gefunden"
  exit 1
fi

FTP_HOST=$(grep '^FTP_HOST=' .env | cut -d'=' -f2-)
FTP_USER=$(grep '^FTP_USER=' .env | cut -d'=' -f2-)
FTP_PASS=$(grep '^FTP_PASS=' .env | cut -d'=' -f2-)
FTP_REMOTE=$(grep '^FTP_REMOTE=' .env | cut -d'=' -f2-)

echo "Baue Projekt..."
npm run build

DRY_RUN=""
if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN="--dry-run"
  echo "DRY-RUN: Keine Dateien werden hochgeladen."
fi

echo "Lade Dateien hoch nach $FTP_HOST:$FTP_REMOTE ..."
lftp -u "$FTP_USER","$FTP_PASS" "ftp://$FTP_HOST" -e "
  set ssl:verify-certificate no
  mirror -R --delete --verbose $DRY_RUN ./dist $FTP_REMOTE
  quit
"

echo "Deploy abgeschlossen."
