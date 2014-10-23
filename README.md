## Running the project for development

First ensure Vagrant is installed correctly.

Then run `vagrant up` to provision the development environment.

Navigation to http://localhost:8000 to view the application.

### Development services

Services are managed by supervisor and are started when the VM is provisioned.

Add/adjust services in the `supervisord.conf` file in the root of the project directory.

Default services are as follows:

* A node web server
* compass watcher (for compiling sass)

## Development workflow

There's no need to manually start any services, or to manually compile anything.
Simple change the source files in the `public/` directory.

## Setting up a production environment

We'll be running the application in a Linux Container.