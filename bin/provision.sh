#!/usr/bin/env bash
# provision.sh - Provision and start a dev server, used by Vagrant.

# Is Vagrant running this script?
[ "$1" == '--vagrant' ] && IS_VAGRANT=1 || IS_VAGRANT=0

#if [ "$IS_VAGRANT" -eq 1 ]; then
  # Adjust apt mirrors for faster package downloads
#  sed -i "s/\/\/archive.ubuntu.com/\/\/gb.archive.ubuntu.com/g" /etc/apt/sources.list
#fi

# We need to install fonts to render PDFs correctly.
# Set default options for ttf-mscorefonts-installer package.
debconf-set-selections <<< 'ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true'

echo "Installing packages and updating system..."
apt-get install -y software-properties-common

# Enable multiverse so we can install ttf-mscorefonts-installer
add-apt-repository -y "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe multiverse"
# Add node.js repo
add-apt-repository -y ppa:chris-lea/node.js
# Add nginx repo
add-apt-repository ppa:nginx/stable

apt-get update && apt-get upgrade -y

apt-get install -y ruby-dev git build-essential nodejs ttf-mscorefonts-installer nginx
apt-get autoremove -y
gem install --no-ri --no-rdoc bundler

if [ "$IS_VAGRANT" -eq 1 ]; then

  echo "Setting up Nginx..."
  ln -s /var/www/config/nginx/local/richardwillis.co.local.conf /etc/nginx/sites-enabled/
  ln -s /var/www/config/nginx/local/dev.richardwillis.co.local.conf /etc/nginx/sites-enabled/
  ln -s /var/www/config/nginx/local/staging.richardwillis.co.local.conf /etc/nginx/sites-enabled/
  service nginx restart

  echo "127.0.0.1 richardwillis.co.local staging.richardwillis.co.local dev.richardwillis.co.local" | sudo tee --append /etc/hosts

  echo "Installing project packages..."
  cd /var/www
  bundle install --path vendor/bundle && npm install

  echo "Building project..."
  npm run build
fi

echo "All done!"
