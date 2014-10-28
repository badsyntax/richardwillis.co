#!/usr/bin/env bash
# provision.sh - Provision and start a dev server, used by Vagrant.
# DO NOT USE FOR PRODUCTION PROVISIONING

# Adjust apt mirrors for faster package downloads
sed -i "s/\/\/archive.ubuntu.com/\/\/gb.archive.ubuntu.com/g" /etc/apt/sources.list

# We need to install fonts to render PDFs correctly.
# Set default options for ttf-mscorefonts-installer package.
debconf-set-selections <<< 'ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true'

echo "Updating system..."
apt-get update && apt-get upgrade -y

echo "Installing packages..."
apt-get remove -y ruby1.8
apt-get install -y python-software-properties

# Enable multiverse so we can install ttf-mscorefonts-installer
add-apt-repository -y "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe multiverse"

add-apt-repository -y ppa:chris-lea/node.js && apt-get update
apt-get install -y git supervisor build-essential nodejs ruby1.9.3 ttf-mscorefonts-installer
apt-get autoremove -y
gem install --no-ri --no-rdoc bundler

cd /var/www

echo "Installing project packages..."
bundle install && npm install

echo "Setting up services..."
ln -s /var/www/supervisord.conf /etc/supervisor/conf.d/richardwillis.co.conf
service supervisor stop
service supervisor start

echo "Building project..."
npm run build

echo "All done!"