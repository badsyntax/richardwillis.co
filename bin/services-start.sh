#!/usr/bin/env bash
# services-start.sh - Start all application services

readonly ENV="$1"

if [ "$ENV" != "staging" ] && [ "$ENV" != "production" ]; then
  echo $"Usage: $0 {staging|production}"
  exit 1
fi

echo "Starting services..."
supervisord -c "/var/www/$ENV/current/config/supervisord.conf"
echo "Done."