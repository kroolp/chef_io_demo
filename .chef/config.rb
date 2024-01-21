current_dir = File.dirname(__FILE__)
node_name                "test_user"
client_key               "#{current_dir}/test_user.pem"
chef_server_url          "http://10.0.0.101/organizations/test-org"
cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_copyright       "Your Company, Inc."
cookbook_license         "Apache-2.0"
cookbook_email           "cookbooks@yourcompany.com"
ssl_verify_mode          :verify_none