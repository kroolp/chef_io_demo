describe bash('ruby -v') do
  its('stdout') { is_expected.to include '3.3.0' }
end