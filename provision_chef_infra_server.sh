sudo apt-get update
sudo apt-get install -yq wget
sudo wget https://packages.chef.io/files/stable/chef-server/15.9.20/ubuntu/20.04/chef-server-core_15.9.20-1_amd64.deb
sudo dpkg -i chef-*.deb
sudo rm chef-*.deb
sudo echo "nginx['enable_non_ssl']=true" > /etc/opscode/chef-server.rb
sudo chef-server-ctl reconfigure --chef-license=accept
sleep 10
sudo chef-server-ctl user-create test_user Test test test@example.com password --filename "/etc/chef/keys/test_user.pem"
sudo chef-server-ctl org-create test-org "Test Org, Inc." --association_user test_user --filename "/etc/chef/test-org-validator.pem"