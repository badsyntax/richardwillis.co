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

The following instructions assume you've installed and setup LXC & ZFS correctly.

### Creating the container

Create the container:

```
lxc-create -t ubuntu -n richardwillis.co -B zfs
```

Set disk quota:

```
zfs set quota=10G lxc/richardwillis.co
```

Switch off synchronous file syncing:

```
zfs set sync=disabled lxc/richardwillis.co
```

Auto-start the container on host boot:

```
vi /var/lib/lxc/richardwillis.co/config
# Add lxc.start.auto = 1
```

Next, we'll assign a static IP address, but it's a good idea for LXC to assign
the IP address first to avoid any potentional IP conflicts.

Start the container:

```
lxc-start -n richardwillis.co -d
```

Find the IP address of the container:

```
lxc-ls --fancy
```

Now add the IP address in the config file:

```
vi /var/lib/lxc/richardwillis.co/config
# Add: lxc.network.ipv4 = X.X.X.X
```

Port-forward a random port to the containers' SSH port:

```
iptables -t nat -A PREROUTING -p tcp -d <EXTERNAL_HOST_IP> -j DNAT --dport XXXX --to-destination <CONTAINER_IP>:22
```

Save the rules:

```
iptables-save > /etc/iptables.conf
```

Now log into the server using the default "ubuntu" account: (password is "ubuntu")

```
ssh ubuntu@proxima.cc -p XXXX
sudo -s
```

Add a new user, add user to sudo group:

```
adduser <username>
usermod -aG sudo <username>
```

Now log out, and log back in using the credentials for the user you just created.

Start new shell as root user:

```
sudo -s
```

Remove the ubuntu user:

```
userdel -r ubuntu
```

### Provision the server

As we're not using any advanced provisions tools, we'll manually provision the server.

Refer to the `bin/provision.sh` script to see how to provision the container.

# Deployig the application

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

Add the following to config/deploy.rb:

```ruby
  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end
```

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