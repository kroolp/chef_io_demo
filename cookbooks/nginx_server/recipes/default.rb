nginx_app 'webserver' do
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
end