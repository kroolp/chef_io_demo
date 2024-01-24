apt_update

package 'git'
package 'build-essential'
package 'libssl-dev'
package 'libreadline-dev'
package 'libyaml-dev'
package 'zlib1g-dev'

remote_file '/ruby-3.3.0.tar.gz' do
  source 'https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz'
  action :create
end

archive_file '/ruby-3.3.0.tar.gz' do
  destination '/ruby'
end

execute './configure' do
  cwd '/ruby/ruby-3.3.0'
end

execute 'make' do
  cwd '/ruby/ruby-3.3.0'
end

execute 'make install' do
  cwd '/ruby/ruby-3.3.0'
end

git '/app' do
  repository 'https://github.com/kroolp/rails_example_app.git'
end

execute 'bundle install' do
  cwd '/app'
end

execute 'rails server' do
  cwd '/app'
end

# nginx_install 'nginx' do
#   source 'distro'
# end

# nginx_site 'test_site' do
#   mode '0644'

#   variables(
#     'server' => {
#       'listen' => [ '*:80' ],
#       'server_name' => [ 'test_site' ],
#       'access_log' => '/var/log/nginx/test_site.access.log',
#       'locations' => {
#         '/' => {
#           'root' => '/var/www/nginx-default',
#           'index' => 'index.html index.htm',
#         },
#       },
#     }
#   )

#   action :create
# end

# nginx_config 'nginx' do
#   action :create
#   notifies :reload, 'nginx_service[nginx]', :delayed
# end

# nginx_service 'nginx' do
#   action :enable
#   delayed_action :start
# end