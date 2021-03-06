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
install_mirror = node[cookbook_name]['install_mirror']
log_directory = node[cookbook_name]['log_directory']
log_file = node[cookbook_name]['log_file']
version = node[cookbook_name]['version']

directory install_directory do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
end

apt_update 'update'
package 'libtool-bin'

file "#{install_directory}/#{install_file}" do
  only_if { ::File.exist? "#{install_directory}/#{install_file}" }
  owner user
  group group
  action :delete
end

remote_file "#{install_directory}/#{install_file}" do
  source install_mirror
  owner user
  group group
  mode '0755'
  action :create
end

# setup log_file to allow root and non root 
file "#{log_directory}/#{log_file}" do
  not_if { ::File.exist? "#{log_directory}/#{log_file}" }
  owner 'syslog'
  group 'adm'
  mode '0664'
  action :create
end

# snoopy conf
template '/etc/snoopy.ini' do
  source 'snoopy.ini.erb'
  mode '0644'
  variables(
    log_directory: log_directory,
    log_file: log_file
  )
  notifies :run, "execute[install #{install_file}]", :immediately
end

execute "install #{install_file}" do
  command "./snoopy-install.sh #{version}"
  only_if { ::File.exist? "#{install_directory}/#{install_file}" }
  cwd install_directory
end

template '/etc/logrotate.d/snoopy' do
  source 'logrotate/snoopy.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    log_directory: log_directory,
    log_file: log_file
  )
end