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
version = node[cookbook_name]['version']

directory install_directory do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
end

apt_update
package 'libtool-bin'

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

template '/etc/snoopy.ini' do
  source 'snoopy.ini.erb'
  mode '0644'
  notifies :run, "execute[install #{install_file}]", :immediately
end

execute "install #{install_file}" do
  command "./snoopy-install.sh #{version}"
  only_if { ::File.exist? "#{install_directory}/#{install_file}" }
  cwd install_directory
end