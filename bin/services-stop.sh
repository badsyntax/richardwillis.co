#!/usr/bin/env bash
# services-stop.sh - Stop all application services

echo "Stopping services..."
supervisorctl -c /var/www/config/supervisord.conf stop all
killall supervisord
echo "Done."