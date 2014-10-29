#!/usr/bin/env bash
# services-stop.sh - Stop all application services

readonly ENV="$1"

if [ "$ENV" != "staging" ] && [ "$ENV" != "production" ]; then
  echo $"Usage: $0 {staging|production}"
  exit 1
fi

echo "Stopping services..."
supervisorctl -c "/var/www/$ENV/current/config/supervisord.conf" stop all
killall supervisord
echo "Done."