#!/bin/bash

knife bootstrap 127.0.0.1 -p 2222 -U vagrant -i .vagrant/machines/node_1/virtualbox/private_key -N node_1 --node-ssl-verify-mode none --policy-group production --policy-name webserver --sudo
knife bootstrap 127.0.0.1 -p 2223 -U vagrant -i .vagrant/machines/node_2/virtualbox/private_key -N node_2 --node-ssl-verify-mode none --policy-group production --policy-name database --sudo