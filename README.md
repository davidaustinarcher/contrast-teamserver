# contrast-teamserver

# Contrast-TeamServer Cookbook
This cookbook installs the Contrast TeamServer on Linux (Debian/Ubuntu or Redhat/Centos platforms).

## Prerequisites
This cookbook does not include the Contrast TeamServer installer, which you can download using an account at https://hub.contrastsecurity.com.  The installer is not included with this cookbook because of its file size and it's best to get the latest version from hub.contrastsecurity.com.

Once you've downloaded the TeamServer installer, which is a shell script with a filename of `Contrast-{version number}.sh`, move the installer file to the cookbook's `files/default` directory.  For example:
`mv ~/Downloads/Contrast-{version number}.sh ~/cookbook/location/contrast-teamserver/files/default/Contrast-{version number}.sh`

Next edit the default attributes file (`.../attributes/default.rb`) and update the `default['contrast-teamserver']['installer']` attribute value to match the TeamServer install filename (i.e., `Contrast-{version number}.sh`).

Please note that this cookbook will take some time to run (about a half hour) and TeamServer will still not be ready until about 5-15 minutes after the cookbook execution is complete due to the delay associated with installing, configuring, and initializing TeamServer for the first time.