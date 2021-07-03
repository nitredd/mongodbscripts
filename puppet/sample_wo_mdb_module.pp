apt::source { 'mdb':
  location => 'https://repo.mongodb.org/apt/ubuntu',
  repos => 'multiverse',
  key => '20691EEC35216C63CAF66CE1656408E390CFB1F5',
  release  => "${facts['os']['distro']['codename']}/mongodb-org/4.4"
}

Apt::Source['mdb'] -> Class['apt::update'] -> Package['mdb'] -> Service['mdb_svc'] -> Exec['mdb_sample_doc']

package {'mdb':
  name => 'mongodb-org',
  ensure => installed
}

file_line {'bind_ip_0':
  ensure => present,
  path => '/etc/mongod.conf',
  line => '  bindIp: 0.0.0.0',  #Dont do this if exposed to public
  match => '^ *bindIp:'
}

service {'mdb_svc':
  name => 'mongod',
  ensure => running,
  enable => true
}

exec { 'mdb_sample_doc':
  path => '/usr/bin',
  command => "mongo --eval 'db.sample.updateOne({_id: 1}, {\$set: {isSample: true}}, {upsert: true})'"
}
