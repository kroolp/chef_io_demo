file 'webserver.txt' do
  content "This is the example of the webserver for host: #{node['webserver_host']}"
end