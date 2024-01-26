#!/bin/bash

chef push production policyfiles/webserver.rb.lock.json
chef push production cookbooks/nginx_server/policyfiles/load_balancer.rb.lock.json

chef push production cookbooks/database/Policyfile.lock.json
chef push production cookbooks/webserver/Policyfile.lock.json