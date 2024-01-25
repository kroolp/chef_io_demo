postgresql_install 'postgresql' do
  source :os
  action %i(install init_server)
end