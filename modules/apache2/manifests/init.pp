class apache2 {

  package {"apache2":
    ensure => "present",
  }

  file {"/etc/apache2/sites-available/default":
    ensure => present,
    owner => "root",
    group => "root",
    content => template("apache2/default.erb"),
    require => Package["apache2"],
    notify => Exec["reload-apache2"]
  }
  
  file {"/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    require => Package["apache2"],
    notify => Exec["reload-apache2"]
  }
  
  service { "apache2":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package["apache2"],
  }

  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => '../mods-available/rewrite.load',
    require => Package["apache2"],
    notify => Exec["reload-apache2"]
  }
  
  exec { "reload-apache2":
    command => "/etc/init.d/apache2 reload",
    refreshonly => true,
  }

}