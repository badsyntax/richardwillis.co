## Running the project for development

First ensure Vagrant is installed correctly.

Then run `vagrant up` to provision the development environment.

Navigation to http://localhost:8000 to view the application.

If you've run `vagrant halt && vagrant up` then you'll need to manually restart
supervisor.

```
vagrant ssh
sudo service supervisor stop
sudo service supervisor start
```

### Development services

Services are managed by supervisor and are started when the VM is provisioned.

Add/adjust services in the `supervisord.conf` file in the root of the project directory.

Default services are as follows:

* A node web server
* compass watcher (for compiling sass)

## Development workflow

There's no need to manually start any services, or to manually compile anything.
Simple change the source files in the `public/` directory.

## Production environment setup

View the wiki for instructions.

# Deploying the application

Although continous integration has been setup through jenkins, you can still manually
deploy as follows.

We will be deploying the application from the host machine and NOT from within the Vagrant VM.

To being, ensure you have ruby-dev and bundler installed on your local machine:

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