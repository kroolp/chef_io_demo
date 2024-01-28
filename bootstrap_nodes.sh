#!/bin/bash

knife bootstrap 127.0.0.1 -p 2222 -U vagrant -i .vagrant/machines/load_balancer/virtualbox/private_key -N load_balancer --node-ssl-verify-mode none --policy-group production --policy-name load_balancer --sudo
knife bootstrap 127.0.0.1 -p 2223 -U vagrant -i .vagrant/machines/webserver1/virtualbox/private_key -N webserver_1 --node-ssl-verify-mode none --policy-group production --policy-name webserver --sudo
knife bootstrap 127.0.0.1 -p 2224 -U vagrant -i .vagrant/machines/webserver2/virtualbox/private_key -N webserver2 --node-ssl-verify-mode none --policy-group production --policy-name webserver --sudo
knife bootstrap 127.0.0.1 -p 2225 -U vagrant -i .vagrant/machines/node_2/virtualbox/private_key -N database --node-ssl-verify-mode none --policy-group production --policy-name database --sudo