#
# Cookbook:: snoopy-cookbook
# Attribute:: default
#
# Copyright:: 2019, BaritoLog.
#
#

cookbook_name = 'snoopy'

default[cookbook_name]['user'] = cookbook_name
default[cookbook_name]['group'] = cookbook_name
default[cookbook_name]['install_directory'] = "/opt/#{cookbook_name}"
default[cookbook_name]['install_file'] = "snoopy-install.sh"
default[cookbook_name]['version'] = "stable"


