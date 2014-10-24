#!/usr/bin/env bash
# provision.sh - Provision and start a dev server, used by Vagrant.
# DO NOT USE FOR PRODUCTION PROVISIONING

# Adjust apt mirrors for faster package downloads
sed -i "s/archive.ubuntu.com/gb.archive.ubuntu.com/g" /etc/apt/sources.list

echo "Updating system..."
apt-get update && apt-get upgrade -y

echo "Installing packages..."
apt-get install -y python-software-properties
add-apt-repository ppa:chris-lea/node.js -y && apt-get update
apt-get install -y git supervisor build-essential nodejs ruby-dev rubygems
gem install --no-ri --no-rdoc bundler

cd /var/www

echo "Installing project packages..."
bundle install && npm install

echo "Building project..."
npm run build

echo "Starting services..."
supervisord -c /var/www/supervisord.conf

echo "All done!"