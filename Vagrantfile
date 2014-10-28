# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/precise64"
  config.vm.provision :shell, path: "bin/provision.sh"
  config.vm.network :forwarded_port, host: 8000, guest: 8000
  config.vm.synced_folder "./", "/var/www"
end
