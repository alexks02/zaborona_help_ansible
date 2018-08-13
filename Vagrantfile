# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

VAGRANTFILE_API_VERSION = "2"

current_dir  = File.dirname(File.expand_path(__FILE__))
config       = YAML.load_file("#{current_dir}/vagrant.yaml")
vars         = config['vars']
plugins      = config['plugins']
need_restart = false

plugins.each do |plugin|
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    need_restart = true
  end
end


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = false

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.provider :virtualbox do |v|
    v.name = "zaborona"
    v.memory = 512
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.hostname = "zaborona"
  config.vm.network :private_network, ip: "#{vars['zaborona_ip']}"

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define :zaborona do |zaborona|
  end

  config.vm.provision 'shell',
    privileged: true,
    run: 'once',
    inline: <<-SHELL
      apt-get update && apt-get -y dist-upgrade && apt-get -y install python
    SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.inventory_path = "provisioning/inventory"
    ansible.become = true
    #ansible.raw_arguments = ["-vvv"]
  end

end
