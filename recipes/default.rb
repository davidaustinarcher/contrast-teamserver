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
cookbook_file '/opt/prod_dev.lic' do
  source 'prod_dev.lic'
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
end

# # Manually stop and start the `contrast-server` service to ensure it is properly initialized
# execute `stop contrast-server service` do
#   command `sudo service contrast-server stop`
# end

# execute `start contrast-server service` do
#   command `sudo service contrast-server start`
# end
