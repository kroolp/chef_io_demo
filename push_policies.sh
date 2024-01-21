#!/bin/bash

chef push production cookbooks/database/Policyfile.lock.json
chef push production cookbooks/webserver/Policyfile.lock.json