#!/usr/bin/env bash
# services-start.sh - Start all application services

echo "Starting services..."
supervisord -c /var/www/config/supervisord.conf
echo "Done."