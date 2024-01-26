Vagrant.configure("2") do |config|
  config.vm.define "chef-infra-server" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network :private_network, ip: "10.0.0.101"
    app.vm.network :forwarded_port, guest: 22, host: 2221
    app.vm.synced_folder ".chef", "/etc/chef/keys"
    app.vm.provision :shell, path: "provision_chef_infra_server.sh"
    app.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "4096"
      vb.cpus = 2
    end
  end

  config.vm.define "load_balancer" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network :private_network, ip: "10.0.0.102"
    app.vm.network :forwarded_port, guest: 22, host: 2222
  end

  config.vm.define "webserver1" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network :private_network, ip: "10.0.0.103"
    app.vm.network :forwarded_port, guest: 22, host: 2223
    app.vm.network :forwarded_port, guest: 80, host: 8080
  end

  config.vm.define "webserver2" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network :private_network, ip: "10.0.0.104"
    app.vm.network :forwarded_port, guest: 22, host: 2224
  end

  config.vm.define "database" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network :private_network, ip: "10.0.0.105"
    app.vm.network :forwarded_port, guest: 22, host: 2225
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
    vb.cpus = 1
  end
end
  