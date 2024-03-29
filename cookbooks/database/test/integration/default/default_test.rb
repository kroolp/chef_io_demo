describe bash('psql --version') do
  its('stdout') { is_expected.to include '12.17' }
end

describe bash('PGPASSWORD=12345 psql -h localhost -U rails_user -d rails_app_production -c "SELECT current_database();"') do
  its('stdout') { is_expected.to include 'rails_app_production' }
end