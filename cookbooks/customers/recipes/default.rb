include_recipe "application"

application 'csutomers' do
  path         '/opt/customers'
  owner        node['tomcat']['user']
  group        node['tomcat']['group']
  repository   node['customers']['jar']['url']
  revision     node['customers']['jar']['checksum']
  scm_provider Chef::Provider::RemoteFile::Deploy

  java_webapp

  tomcat
end

