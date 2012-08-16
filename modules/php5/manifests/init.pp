class php5 {
  
  package {"php5":
    ensure => "present",
  }
  
  package {"libapache2-mod-php5":
    ensure => "present",
    notify => Exec["reload-apache2"],
  }
  
  package {"php5-gd":
    ensure => "present",
    notify => Exec["reload-apache2"]
  }
  
  package {"php-pear":
    ensure => "present",
  }

  package {"php5-mysql":
    ensure => present,
    notify => Exec["reload-apache2"]
  }
  
  file {"/etc/php5/apache2/php.ini":
    ensure => present,
    owner => "root",
    group => "root",
    content => template("php5/php.ini.erb"),
    require => [
      Package["php5"],
      Package["libapache2-mod-php5"]
    ],
    notify => Exec["reload-apache2"]
  }
  
}