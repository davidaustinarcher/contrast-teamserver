#
# Cookbook:: contrast-teamserver
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install MySQL libaio package
case node['platform']
when 'debian', 'ubuntu'
  package 'libaio1'
  package 'libaio-dev'
when 'redhat', 'centos'
  package 'libaio'
end

# Create temp directory for Contrast TeamServer installer
directory '/opt/contrast-installer' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Transfer Contrast TeamServer installer to local directory
cookbook_file "/opt/contrast-installer/#{ node['contrast-teamserver']['installer'] }" do
  source node['contrast-teamserver']['installer']
  mode '0755'
end

# Transfer demo license to local directory
cookbook_file "/opt/#{ node['contrast-teamserver']['license'] }" do
  source "#{ node['contrast-teamserver']['license'] }"
end

# Create variables file to pass to the unattended install for TeamServer
template '/opt/vars.txt' do
  source 'vars.txt.erb'
end

# Install Contrast TeamServer
execute 'Run Contrast TeamServer install script' do
  command "sudo ./#{ node['contrast-teamserver']['installer'] } -q -varfile /opt/vars.txt"
  cwd '/opt/contrast-installer'
  not_if { ::File.exist?('/opt/contrast/bin/contrast-server')}
  notifies :run, 'execute[stop_contrast]', :immediately
end

# Manually stop the `contrast-server` service to ensure it is properly initialized
execute 'stop_contrast' do
  command 'sudo service contrast-server stop'
  cwd '/opt/contrast/bin'
  action :nothing
  notifies :create, 'template[/opt/contrast/data/conf/general.properties]', :immediately
  notifies :create, 'template[/opt/contrast/data/conf/mysql.properties]', :immediately
end

# Update TeamServer URL
template '/opt/contrast/data/conf/general.properties' do
  source 'general.properties.erb'
  action :nothing
end

# Update TeamServer MySQL buffer pool size configuration
template '/opt/contrast/data/conf/mysql.properties' do
  source 'mysql.properties.erb'
  action :nothing
  notifies :run, 'execute[start_contrast]', :delayed
end

# Manually start the 'contrast-server' service to ensure it is properly started
execute 'start_contrast' do
  command 'sudo service contrast-server start'
  cwd '/opt/contrast/bin'
  action :nothing
end
