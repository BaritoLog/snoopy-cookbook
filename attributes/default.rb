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
default[cookbook_name]['install_file'] = 'snoopy-install.sh'
default[cookbook_name]['install_mirror'] = 'https://github.com/a2o/snoopy/raw/install/doc/install/bin/snoopy-install.sh'
default[cookbook_name]['log_file'] = 'snoopy.log'
default[cookbook_name]['log_directory'] = '/var/log'
default[cookbook_name]['version'] = 'git-360bb18'
