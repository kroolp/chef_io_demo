rails_env_variables = {
  'RAILS_ENV' => 'production',
  'DATABASE_ADAPTER' => node['database_adapter'],
  'DATABASE_HOST' => node['database_host'],
  'DATABASE_NAME' => node['database_name'],
  'DATABASE_USERNAME' => node['database_username'],
  'DATABASE_PASSWORD' => node['database_password'],
  'SERVER_HOST' => node['server_host']
}.compact

package 'libpq5'
package 'libpq-dev'

git '/app' do
  repository node['app_repository']
end

execute 'bundle install' do
  cwd '/app'
end

file '/app/config/master.key' do
  content node['app_master_key']
  mode '0644'
end

if node['create_db'] == true
  execute 'rails db:create' do
    cwd '/app/bin'
    environment rails_env_variables
  end
end

execute 'rails db:migrate' do
  cwd '/app/bin'
  environment rails_env_variables
end

execute 'rails assets:precompile' do
  cwd '/app/bin'
  environment rails_env_variables
end

execute "rails server --daemon" do
  cwd '/app/bin'
  environment rails_env_variables
end
  