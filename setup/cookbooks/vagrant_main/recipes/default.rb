# Some neat package
%w{ debconf php5-xdebug git-core htop screen curl vim }.each do |a_package|
  package a_package
end

include_recipe "apt"
include_recipe "multitail"
include_recipe "htop"
include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_apc"
include_recipe "php::module_curl"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"

s = "aequasi"
site = {
  :name => s,
  :host => "dev.#{s}",
  :aliases => [ "dev.#{s}.com" ]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/"
end

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} >> /etc/hosts"
end

execute "add-bash-files" do
    command "cat /vagrant/setup/bash/bash.bashrc >> /etc/bash.bashrc"
	only_if { `cat /etc/bash.bashrc | grep "Setting Custom PS1"` == "" }
	action :run
	ignore_failure true
end