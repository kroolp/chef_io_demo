# Overview

Demo project demonstrating how to set up a Chef architecture with the following components:
- PostgreSQL database
- Nginx load balancer
- Two Ruby on Rails web servers
## Project structure

The project structure consists of several cookbooks:

- ruby: Installs dependencies, downloads the Ruby binary, and compiles it (configure, make, make install)
- rails_app: Clones an existing Rails application repository, migrates the database, precompiles assets, and runs the Puma web server as a daemon
- nginx_server: Uses two recipes: default installs and configures Nginx for the Puma server to bind to a socket, and load_balancer configures the Nginx load balancer for the given hosts
- database: Installs, sets up users and databases, and runs the PostgreSQL database

The project uses the recommended approach of Policyfile, as opposed to the older method of Roles and Environments.

## Setup

You need to install `vagrant`, `virtualbox`, and `chef` packages.

There are two options for running the example infrastructure:

### Kitchen

Kitchen runs via a lightweight Chef Infra server called Chef Zero. Chef Zero runs in memory, and as the documentation says: "This makes it perfect for testing against a "real" Chef Server without mocking the entire Internet."

To create virtual machines:
```
kitchen create
```
To bootstrap clients, install cookbooks, and upload run_list:
```
kitchen converge
```
To run tests (all should pass):
```
kitchen verify
```
To open an SSH session to one of the machines:
```
kitchen login machine_name
```
Example:
```
kitchen login database
```
To destroy all machines:
```
kitchen destroy
```

### Vagrant

Using Vagrant, you can create virtual machines that include a real Chef Infra server.

To build machines:
```
vagrant up
```
To push policies:
```
chef push production cookbooks/database/Policyfile.lock.json
chef push production cookbooks/nginx_server/policyfiles/load_balancer.lock.json
chef push production policyfiles/webserver.lock.json
```
To bootstrap nodes:
```
knife bootstrap 127.0.0.1 -p 2222 -U vagrant -i .vagrant/machines/database/virtualbox/private_key -N database --node-ssl-verify-mode none --policy-group production --policy-name database --json-attribute-file ./attributes/database.json --sudo
```
```
knife bootstrap 127.0.0.1 -p 2223 -U vagrant -i .vagrant/machines/load_balancer/virtualbox/private_key -N load_balancer --node-ssl-verify-mode none --policy-group production --policy-name load_balancer --json-attribute-file ./attributes/load_balancer.json --sudo
```
```
knife bootstrap 127.0.0.1 -p 2224 -U vagrant -i .vagrant/machines/webserver1/virtualbox/private_key -N webserver1 --node-ssl-verify-mode none --policy-group production --policy-name webserver --json-attribute-file ./attributes/webserver1.json --sudo
```
```
knife bootstrap 127.0.0.1 -p 2225 -U vagrant -i .vagrant/machines/webserver2/virtualbox/private_key -N webserver2 --node-ssl-verify-mode none --policy-group production --policy-name webserver --json-attribute-file ./attributes/webserver2.json --sudo
```

Open the following URL in your browser to see the Rails app running:

http://localhost:8080

<img width="1207" alt="Screenshot 2024-01-28 at 00 22 02" src="https://github.com/kroolp/chef_io_demo/assets/10959677/8fe15ae2-15d6-4082-b293-71f0ff26478c">

The load balancer should be distributing traffic from two different IP addresses (as shown in the screenshot's top right corner).

To stop machines without destroying them:
```
vagrant halt
```

To destroy all machines:
```
vagrant destroy
```

## Future Enhancements

Implement Compliance controls and integrate with Chef Automate to visualize compliance data.
