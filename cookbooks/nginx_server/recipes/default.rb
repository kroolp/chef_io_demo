apt_update

nginx_install 'nginx' do
  source 'distro'
end

nginx_site 'app' do
  mode '0644'
  template 'site-template.erb'

  variables(
    'upstream' => {
      'app' => {
        'server' => 'unix:/app/tmp/sockets/puma.sock fail_timeout=0'
      }
    },
    'name' => 'app',
    'server' => {
      'listen' => '80',
      'server_name' => ['localhost'],
      'extra_options' => {
        'root' => '/app/public'
      },
      'locations' => {
          '/' => {
            'try_files' => '$uri @app'
          },
          '@app' => [
            ['proxy_set_header', 'Host $http_host'],
            ['proxy_set_header', 'X-Forwarded-For $proxy_add_x_forwarded_for'],
            ['proxy_set_header', 'X-Forwarded-Proto $scheme'],
            ['proxy_pass', 'http://app']
          ]
      }
    }
  )

  action :create
end

nginx_config 'nginx' do
  action :create
  default_site_enabled false
  notifies :reload, 'nginx_service[nginx]', :delayed
end

nginx_service 'nginx' do
  action :enable
  delayed_action :start
end

