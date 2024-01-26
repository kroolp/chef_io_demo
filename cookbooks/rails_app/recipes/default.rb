git '/app' do
  repository 'https://github.com/kroolp/rails_example_app.git'
end

execute 'bundle install' do
  cwd '/app'
end

file '/app/config/master.key' do
  content 'fb6e23fe35de1ea569dcb34cc340108c'
  mode '0644'
end

execute 'RAILS_ENV=production bin/rails db:create db:migrate' do
  cwd '/app'
end

execute 'RAILS_ENV=production bin/rails assets:precompile' do
  cwd '/app'
end

execute "RAILS_ENV=production SERVER_HOST=\"#{node['host']}\" bin/rails server --daemon" do
  cwd '/app'
end
  