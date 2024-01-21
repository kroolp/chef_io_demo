file 'database.txt' do
  content "This is the example of the db with port: #{node['db_port']}"
end