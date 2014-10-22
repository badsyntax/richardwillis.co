## Running the project

First ensure Vagrant is installed correctly.

Then run `vagrant up` to provision the development environment.

As part of the provisioning, supervisor will be launched using the config found
in app/supervisord.conf. Once vagrant completed the provisioning, you can navigate to
http://localhost:8000 to view the application.


