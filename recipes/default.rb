reboot 'later' do
  action :nothing
  reason 'requires reboot'
end

# set the service user to auto login on boot
registry_key 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' do
  values [{
    :name => "DefaultUserName",
    :type => :string,
    :data => node['windows_auto_login']['user']
  }, {
    :name => "DefaultPassword",
    :type => :string,
    :data => node['windows_auto_login']['password']
  }, {
    :name => "DefaultDomainName",
    :type => :string,
    :data => node['windows_auto_login']['domain_name']
  }, {
    :name => "AutoAdminLogon",
    :type => :string,
    :data => "1"
  }]
  notifies :request_reboot, 'reboot[later]', :immediately
end
