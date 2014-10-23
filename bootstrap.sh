#!/usr/bin/env bash
# boostrap.sh - used by vagrant to provision a dev environment

cat > /etc/apt/sources.list << EOL
  deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse
EOL

# Install OS dependencies
apt-get update && apt-get upgrade -y
apt-get install -y python-software-properties

add-apt-repository ppa:chris-lea/node.js && apt-get update
apt-get install -y supervisor build-essential nodejs ruby-dev

gem install --no-ri --no-rdoc bundler

# Install app dependencies
cd /var/www && npm install && bundle install

# Start services
supervisord -c /var/www/supervisord.conf