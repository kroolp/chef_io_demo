# Overview

Demo project showing how to setup Chef architecture with following components:
- Postgresql database
- ngnix load balancer
- 2 Ruby on Rails webservers

## Project structure

Project structure consists of several cookbooks:
- ruby - installs dependencies, downloads ruby binary and compliles it (configure, make, make install),
- rails_app - clones exisiting rails application repository, migrates database, precompiles assets, runs puma webserver as daemon,
- ngnix_server - uses 2 recepies - default installs and configures nginx for puma server binding to socket, load_balancer - configures ngnix load balancer for given hosts
- database - installs, setups users and database then running postgresql database

Approach is using recommended way with Policyfile as opposed to old way of Roles and Environments.

## Setup

You need to install `vagrant`, `virtualbox` and `chef` packages.

There are two options of running example infrastructure:

### Kitchen

It runs via lightweight `chef_zero` - chef infra server. It works in-memory and as documentation says: "This makes it perfect for testing against a "real" Chef Server without mocking the entire Internet."

To create virtual machines:
```
kitchen create
```
To bootstrap clients, install cookbooks and upload run_list:
```
kitchen converge
```
To runs tests (all should pass):
```
kitchen verify
```
To open ssh session to one of the machines:
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

Via Vagrant you get virtual machines including real Chef infra server.

To build machines:
```
vagrant up
```
Push policies:
```
chef push production cookbooks/database/Policyfile.lock.json
chef push production cookbooks/nginx_server/policyfiles/load_balancer.lock.json
chef push production policyfiles/webserver.lock.json
```
Bootstrap nodes:
```
knife bootstrap 127.0.0.1 -p 2222 -U vagrant -i .vagrant/machines/load_balancer/virtualbox/private_key -N load_balancer --node-ssl-verify-mode none --policy-group production --policy-name load_balancer --sudo
```
```
knife bootstrap 127.0.0.1 -p 2223 -U vagrant -i .vagrant/machines/webserver1/virtualbox/private_key -N webserver_1 --node-ssl-verify-mode none --policy-group production --policy-name webserver --sudo
```
```
knife bootstrap 127.0.0.1 -p 2224 -U vagrant -i .vagrant/machines/webserver2/virtualbox/private_key -N webserver2 --node-ssl-verify-mode none --policy-group production --policy-name webserver --sudo
```
```
knife bootstrap 127.0.0.1 -p 2225 -U vagrant -i .vagrant/machines/node_2/virtualbox/private_key -N database --node-ssl-verify-mode none --policy-group production --policy-name database --sudo
```

Open in the browser below URL to see the Rails app running.

http://localhost:8080

<img width="1207" alt="Screenshot 2024-01-28 at 00 22 02" src="https://github.com/kroolp/chef_io_demo/assets/10959677/8fe15ae2-15d6-4082-b293-71f0ff26478c">


Notice that load balancer provides traffic from two different IP (you can see that displayed in the top right corner).

To stop machines (without destroying them):
```
vagrant halt
```

To destroy all machines:
```
vagrant destroy
```

## Future enhancements

Implementing Compliance controls and integrating with Automate to visualize them.
