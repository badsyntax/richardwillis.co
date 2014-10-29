#!/usr/bin/env bash
# services-stop.sh - Stop all application services

readonly ENV="$1"

if [ "$ENV" != "staging" ] && [ "$ENV" != "production" ]; then
  echo $"Usage: $0 {staging|production}"
  exit 1
fi

echo "Restarting services..."
supervisord -c "/var/www/staging/current/config/supervisord.conf"
supervisorctl -c "/var/www/$ENV/current/config/supervisord.conf" restart all
echo "Done."