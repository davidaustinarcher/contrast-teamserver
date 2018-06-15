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

# Transfer Contrast TeamServer installer to local directory
cookbook_file '/home/vagrant/Contrast-3.5.2.634.sh' do
  source 'Contrast-3.5.2.634.sh'
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
  command 'sudo ./Contrast-3.5.2.634.sh -q -varfile /opt/vars.txt'
  cwd '/home/vagrant'
  not_if { ::File.exist?('/opt/contrast/bin/contrast-server')}
end