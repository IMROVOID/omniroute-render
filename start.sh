#!/bin/sh
set -e

# If SQLite database doesn't exist yet (fresh container or after Render sleep)
if [ ! -f /app/data/storage.sqlite ]; then
  mkdir -p /app/data

  if [ -f /etc/secrets/backup.json ]; then
    echo "[AUTOLOAD] Found /etc/secrets/backup.json -> copying to /app/data/db.json for auto-migration"
    cp /etc/secrets/backup.json /app/data/db.json
  elif [ -f /etc/secrets/omniroute-backup.json ]; then
    echo "[AUTOLOAD] Found /etc/secrets/omniroute-backup.json -> copying to /app/data/db.json for auto-migration"
    cp /etc/secrets/omniroute-backup.json /app/data/db.json
  elif [ -f /app/backup.json ]; then
    echo "[AUTOLOAD] Found /app/backup.json -> copying to /app/data/db.json for auto-migration"
    cp /app/backup.json /app/data/db.json
  fi
fi

# Run OmniRoute's original startup flow
if [ -x /app/check-permissions.sh ]; then
  exec /app/check-permissions.sh node dev/run-standalone.mjs
else
  exec node dev/run-standalone.mjs
fi
