describe bash('psql --version') do
  its('stdout') { is_expected.to include '12.17' }
end

describe bash('PGPASSWORD=12345 psql -h localhost -U postgres -c "\l"') do
  its('stdout') { is_expected.to include 'rails_db' }
end
