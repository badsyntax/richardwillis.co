# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.vm.provision :shell, path: "bin/provision.sh", :args => "--vagrant"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.synced_folder "./", "/var/www"
end
