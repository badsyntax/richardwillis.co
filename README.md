# Richard Willis - Freelance Web Developer

My personal site.

## Running the project for development

Install virtualbox, any version higher than 4.3.10. Things will not work with
4.3.10 due to [https://www.virtualbox.org/ticket/12879](a bug) with this version:

On Ubuntu host:

```
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-4.3
```

Then install Vagrant, and the vagrant-vbguest plugin to ensure vagrant guest is up-to-date:

```
vagrant plugin install vagrant-vbguest
```

Run `vagrant up` to provision the development environment.

Once the VM is created and ready to use, ssh into the machine and start the watchers and node server:

```
vagrant ssh
cd /var/www
npm run watch
npm run start-staging # to start the staging instance
npm run start-dev # to start the dev instance
npm run start # to start the prod instance
```

Adjust the hostnames to point to the VM:

```
echo "192.168.50.4 richardwillis.co.local staging.richardwillis.co.local dev.richardwillis.co.local" | sudo tee --append /etc/hosts
```

* Navigate to http://dev.richardwillis.co.local/ to view the application in dev mode.
* Navigate to http://staging.richardwillis.co.local/ to view the application in staging mode.
* Navigate to http://richardwillis.co.local/ to view the application in prod mode.

## Production environment setup

View the wiki for instructions.

# Deploying the application

Although continuous integration has been setup through Jenkins, you can still manually
deploy as follows.

(We will be deploying the application from the host machine and NOT from within the Vagrant VM.)

To begin, ensure you have ruby-dev and bundler installed on your local machine:

```
sudo apt-get install ruby-dev
sudo gem install bundler
```

Then install gems from the project root:

```
bundler install
```

Follow the instructions on this page to setup authentication and authorisation: http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/

Check tasks:

```
cap -T
```

Run task for staging:

```
cap staging deploy:check_write_permissions
```

Check git:

```
cap staging git:check
```

Deploy:

```
cap staging deploy
```
