default['go']['backup_path'] = ''
default['go']['backup_retrieval_type'] = 'local'

default['go']['agent']['auto_register']         = false
default['go']['agent']['auto_register_key']     = 'default_auto_registration_key'
default['go']['agent']['auto_register_resources'] = []
default['go']['agent']['auto_register_environments'] = []

# Install this many agent instances on a box - default is one per CPU

default['go']['agent']['instance_count'] = node['cpu']['total']
default['go']['agent']['server_search_query'] =
  "chef_environment:#{node.chef_environment} AND recipes:go\\:\\:server"


default['go']['version']                       = '15.2.0-2248'
default['java']['jdk_version'] = '7'

unless platform?('windows')
  default['go']['agent']['java_home']             = '/usr/bin/java'
  default['go']['agent']['work_dir_path']         = '/var/lib'
end

default['go']['server']['install_path'] = 'C:\Program Files (x86)\Go Server'
