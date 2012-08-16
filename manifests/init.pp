class instance {
  
  include apt
  
  class { 'mysql': }
  class { 'mysql::server':
    config_hash => { 'root_password' => 'root' }
  }
  
  include apache2
  
  include php5

  include drush
  
  file { ["/var", "/var/www"]:
    ensure => "directory",
    mode => 0777
  }
  
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  
  
}

include instance
