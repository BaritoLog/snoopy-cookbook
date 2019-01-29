#
# Cookbook:: snoopy-cookbook
# Recipe:: user
#
# Copyright:: 2019, BaritoLog.
#
#

group node[cookbook_name]['group'] do
  system true
end

user node[cookbook_name]['user'] do
  comment "#{node[cookbook_name]['user']} user"
  group node[cookbook_name]['group']
  system true
  manage_home true
  home "/home/#{node[cookbook_name]['user']}"
end