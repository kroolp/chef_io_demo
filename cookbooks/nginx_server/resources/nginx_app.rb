provides :nginx_app

property :variables, Hash,
  description: 'Variables with nginx app setup',
  default: {}

action :create do
  apt_update

  nginx_install 'nginx' do
    source 'distro'
  end

  nginx_site 'app' do
    mode '0644'
    template 'site-template.erb'
    variables(new_resource.variables)

    action :create
  end

  nginx_config 'nginx' do
    action :create
    default_site_enabled false
    notifies :reload, 'nginx_service[nginx]', :delayed
  end

  nginx_service 'nginx' do
    action :enable
    delayed_action :start
  end
end
