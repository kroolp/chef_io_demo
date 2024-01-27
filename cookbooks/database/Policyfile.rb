# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'database'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'database::default'

# Specify a custom source for a single cookbook:
cookbook 'database', path: '.'
cookbook 'postgresql', '~> 11.10.0'

default['staging']['db_port'] = 3306
default['production']['db_port'] = 5432