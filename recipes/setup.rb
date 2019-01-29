#
# Cookbook:: snoopy-cookbook
# Recipe:: setup
#
# Copyright:: 2019, BaritoLog.
#
#

app_name = cookbook_name
user = node[cookbook_name]['user']
group = node[cookbook_name]['group']
install_directory = node[cookbook_name]['install_directory']
install_file = node[cookbook_name]['install_file']

directory install_directory do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
end

file "#{install_directory}/#{install_file}" do
  only_if { ::File.exist? "#{install_directory}/#{install_file}" }
  owner user
  group group
  action :delete
end

remote_file "#{install_directory}/#{install_file}" do
  source 'https://github.com/a2o/snoopy/raw/install/doc/install/bin/snoopy-install.sh'
  owner user
  group group
  mode '0755'
  action :create
end

execute "install #{install_file}" do
  command "./snoopy-install.sh stable"
  only_if { ::File.exist? "#{install_directory}/#{install_file}" }
  cwd install_directory
end
