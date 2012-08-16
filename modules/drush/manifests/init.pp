class drush {

    package {"drush":
        ensure => "present"
    }

    exec{"register-up1-pear":
        command => "/usr/bin/pear upgrade --force Console_Getopt",
        require => Package["php-pear"],
        path => "/home/vagrant",
        notify => Exec["register-up2-pear"]
    } 

    exec{"register-up2-pear":
        command => "/usr/bin/pear upgrade --force pear",
        require => Package["php-pear"],
        path => "/home/vagrant",
        notify => Exec["register-up3-pear"]
    } 

    exec{"register-up3-pear":
        command => "/usr/bin/pear upgrade-all",
        require => Package["php-pear"],
        path => "/home/vagrant",
        notify => Exec["register-drush-pear"]
    }

    exec{"register-drush-pear":
        command => "/usr/bin/pear channel-discover pear.drush.org",
        require => Package["php-pear"],
        path => "/home/vagrant"
    } 

}