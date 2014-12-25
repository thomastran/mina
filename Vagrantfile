# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbooks/playbook.yml'
    ansible.limit = 'default'
  end
end
