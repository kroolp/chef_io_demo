describe bash('psql --version') do
  its('stdout') { is_expected.to include '12.17' }
end