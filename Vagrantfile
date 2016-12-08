# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "box-cutter/debian8"

  # Set the VM hostname
  config.vm.hostname = "predeploy-test"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8983, host: 8983, auto_correct: true
  config.vm.network "forwarded_port", guest: 8984, host: 8984, auto_correct: true
  config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "512"
  end

  # Enable ansible provisioning to setup box prerequites that should be avaialbe on target machines
  config.vm.provision "ansible" do |ansible|
    # Set verbosity of ansible output '' to 'vvv'
    ansible.verbose = 'v'

    ansible.groups = {
      "vagrant" => ["default"]
    }
    
    # Force override of rbenv_root at command line so rbenv install puts it in the specified location
    ansible.extra_vars = {
      rbenv_root: "/l/local/rbenv",
      config_file: "vars/example-vars-staging-expanded.yml"
    }

    ansible.playbook = "playbook.vagrant.yml"
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
end
