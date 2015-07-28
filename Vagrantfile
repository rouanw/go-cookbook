linux_box_name = 'opscode-centos-6.6'
linux_box_url  = "https://opscode-vm.s3.amazonaws.com/vagrant/#{linux_box_name}.box"
windows_box_name = 'vagrant-windows2008r2'
windows_box_url = "http://PUTINYOURBOXSERVERHERE/vagrant/boxes/#{windows_box_name}.box"
api_version = '2'

Vagrant::configure(api_version) do |config|
  config.berkshelf.enabled    = true
  config.omnibus.chef_version = :latest
  config.vm.network "private_network", type: "dhcp"
  
  if Vagrant.has_plugin?("vagrant-cachier")
      # Configure cached packages to be shared between instances of the same base box.
      # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
      config.cache.scope = :box

      # OPTIONAL: If you are using VirtualBox, you might want to use that to enable
      # NFS for shared folders. This is also very useful for vagrant-libvirt if you
      # want bi-directional sync
      config.cache.synced_folder_opts = {
        type: :nfs,
        # The nolock option can be useful for an NFSv3 client that wants to avoid the
        # NLM sideband protocol. Without this option, apt-get might hang if it tries
        # to lock files needed for /var/cache/* operations. All of this can be avoided
        # by using NFSv4 everywhere. Please note that the tcp option is not the default.
        mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
      }
      # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end
  
  config.vm.define 'linux', primary: true do |linux|
    linux.vm.box               = linux_box_name
    linux.vm.box_url           = linux_box_url

    linux.vm.provider :virtualbox do |v|
      v.customize ['modifyvm', :id, '--memory', '2048']
    end

    linux.vm.network "forwarded_port", guest:8153, host: 8153

    linux.vm.provision :chef_solo do |chef|
      chef.log_level = 'info'
      chef.json = {
          'go' => {
              'server' => '127.0.0.1',
              'agent' => {
                  'auto_register' => true,
                  'instance_count' => 3
              }
          }
      }

      chef.run_list = [
          'recipe[go]'
      ]
    end
  end

  # Berkshelf doesn't support multi-VM Vagrantfiles.  Will need to sort this out later.
  #
  # config.vm.define 'windows', autostart: false do |windows|
  #   windows.vm.box               = windows_box_name
  #   windows.vm.box_url           = windows_box_url
  #
  #   windows.vm.provider :virtualbox do |v|
  #     v.gui = true
  #   end
  #
  #   windows.vm.guest = :windows
  #
  #   windows.vm.network :forwarded_port, guest: 5985, host: 5985, auto_correct: true
  #
  #   windows.vm.network :private_network, ip: '192.168.192.3'
  #
  #   windows.vm.provision :chef_solo do |chef|
  #     chef.log_level = 'info'
  #     chef.json = {
  #         'go' => {
  #             'version' => '14.1.0-18882'
  #         }
  #     }
  #
  #     chef.run_list = [
  #         'recipe[go]'
  #     ]
  #   end
  # end

end

  