PACKAGE = 'multitail'

# install package
package PACKAGE do
    action :install
end

# disable email checking in global multitail configuration
ruby_block 'disable_email_checking' do
    block do
        f = Chef::Util::FileEdit.new("/etc/#{PACKAGE}.conf")
        f.search_file_replace(/^check_mail:\d+/, 'check_mail:0')
        f.write_file
    end
    action :create
end
