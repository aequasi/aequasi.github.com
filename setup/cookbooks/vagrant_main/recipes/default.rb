# Some neat package
%w{ debconf git-core htop screen curl vim }.each do |a_package|
  package a_package
end

include_recipe "apt"

s = "aequasi"
site = {
  :name => s,
  :host => "dev.#{s}",
  :aliases => [ "dev.#{s}.com" ]
}

execute "add-bash-files" do
    command "cat /vagrant/setup/bash/bash.bashrc >> /etc/bash.bashrc"
	only_if { `cat /etc/bash.bashrc | grep "Setting Custom PS1"` == "" }
	action :run
	ignore_failure true
end
