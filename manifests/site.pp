node default {
  
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
    enable  => true,
  }
  
  file {'/root/README':
    ensure  => file,
    content => 'This is a readme generated for a default node',
    owner   => 'root',
  }
}

node 'master.puppet.vm' {
  include role::master_server
  
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
  
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
    enable  => true,
  }
}

node /^web/ {
  include role::app_server
  
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
    enable  => true,
  }
  
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}

node /^db/ {
  include role::db_server
}

node /^foxglove/ {
  include role::foxglove_server
}
