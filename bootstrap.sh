#!/usr/bin/env bash
# boostrap.sh - used by vagrant to provision a dev environment

# Adjust apt mirrors for faster package downloads
sed -i "s/archive.ubuntu.com/gb.archive.ubuntu.com/g" /etc/apt/sources.list

# Install OS dependencies
apt-get update && apt-get upgrade -y
apt-get install -y python-software-properties

add-apt-repository ppa:chris-lea/node.js && apt-get update
apt-get install -y git supervisor build-essential nodejs ruby-dev

gem install --no-ri --no-rdoc bundler

# Install app dependencies
cd /var/www && bundle install && npm install && npm run build

# Start services
supervisord -c /var/www/supervisord.conf