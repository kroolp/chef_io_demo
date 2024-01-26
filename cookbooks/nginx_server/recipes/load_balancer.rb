nginx_app 'load_balancer' do
  variables(
    'upstream' => {
      'app' => {
        'server' => node['webservers']
      }
    },
    'name' => 'app',
    'server' => {
      'listen' => '80',
      'server_name' => ['localhost'],
      'locations' => {
        '/' => [
          ['proxy_set_header', 'Host $http_host'],
          ['proxy_set_header', 'X-Forwarded-For $proxy_add_x_forwarded_for'],
          ['proxy_set_header', 'X-Forwarded-Proto $scheme'],
          ['proxy_pass', 'http://app']
        ]
      }
    }
  )
end