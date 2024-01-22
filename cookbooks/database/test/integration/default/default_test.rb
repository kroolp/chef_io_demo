describe file('/database.txt') do
  its('content') { is_expected.to include('port: 1234') }
end