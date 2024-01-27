describe bash('rails -v') do
  its('stdout') { is_expected.to include 'Rails' }
end

describe file('/app/tmp/sockets/puma.sock') do
  it { is_expected.to exist }
end