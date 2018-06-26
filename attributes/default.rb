# Filename of the Contrast TeamServer installer
default['contrast-teamserver']['installer'] = 'contrast-installer.sh'

# Filename of the Contrast license
default['contrast-teamserver']['license'] = 'prod_dev.lic'

# URL to access TeamServer
default['contrast-teamserver']['teamserver_url'] = 'http\://192.168.33.100\:8080/Contrast'

# TeamServer's MySQL `innodb_buffer_pool_size`
default['contrast-teamserver']['innodb_buffer_pool_size'] = '4096M'