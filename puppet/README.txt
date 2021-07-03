After installing the Puppet agent (puppet_inst.sh), the "puppet" executable doesn't get added to the path so do this...

PATH=$PATH:/opt/puppetlabs/bin
sudo `which puppet` apply <file-name>.pp
