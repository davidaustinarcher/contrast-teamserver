# Contrast-TeamServer Cookbook
This cookbook installs the Contrast TeamServer on Linux (Debian/Ubuntu or Redhat/Centos platforms) for demonstration purposes.  It is intended to automate the local installation and setup of TeamServer on a Linux VM hosted on a MacBook Pro with 16GB RAM.

## Prerequisites
You will need to supply your own Contrast TeamServer installer file and license file.

### Add the Contrast TeamServer installer to the cookbook files
This cookbook does not include the Contrast TeamServer installer, which you can download using an account at https://hub.contrastsecurity.com.  The installer is not included with this cookbook because of its file size and it's best to get the latest version from hub.contrastsecurity.com.

1. Log in to your Contrast Hub account at https://hub.contrastsecurity.com
2. Go to the "Downloads" page and download your desired Linux installer
3. Once you've downloaded the TeamServer installer, which is a shell script with a filename of `Contrast-{version number}.sh`, move the installer file to the cookbook's `files/default` directory.  For example:
`mv ~/Downloads/Contrast-{version number}.sh ~/cookbook/location/contrast-teamserver/files/default/Contrast-{version number}.sh`
4. Next edit the default attributes file (`.../attributes/default.rb`) and update the `default['contrast-teamserver']['installer']` attribute value to match the TeamServer install filename (i.e., `Contrast-{version number}.sh`).

### Add your Contrast license to the cookbook files
A license file is purposely not included with this cookbook.  You will need to acquire your own license from your Contrast Account Team or Contrast Support.

## Running this cookbook
Please note that this cookbook will take some time to run (about a half hour) and TeamServer will still not be ready until about 15 minutes after the cookbook execution is complete due to the delay associated with installing, configuring, and initializing TeamServer for the first time.