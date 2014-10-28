#!/usr/bin/env bash
# services-stop.sh - Stop all application services

supervisorctl -c /var/www/supervisord.conf stop all
killall supervisord