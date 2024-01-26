# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
root_dir = Dir.pwd

name 'webserver'

# Where to find external cookbooks:
default_source :supermarket

include_policy 'nginx_server', path: "#{root_dir}/cookbooks/nginx_server/Policyfile.lock.json"
include_policy 'rails_app', path: "#{root_dir}/cookbooks/rails_app/Policyfile.lock.json"

# run_list: chef-client will run these recipes in the order specified.
run_list ['nginx_server::default', 'rails_app::default']

