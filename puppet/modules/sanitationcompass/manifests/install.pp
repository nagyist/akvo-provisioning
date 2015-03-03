
class sanitationcompass::install {

    $username = $sanitationcompass::username
    $approot = $sanitationcompass::approot

    # make sure we also include the Akvoapp stuff, and that it is loaded
    # before this module
    akvoapp { $username:
        deploy_key => hiera('sanitationcompass-deploy_public_key')
    }

    # install all of the support packages
    include pythonsupport::standard
    include pythonsupport::mysql
    include pythonsupport::pil

    file { ["${approot}/versions", "${approot}/db"]:
        ensure  => directory,
        owner   => $username,
        group   => $username,
        mode    => '0755',
        require => [ User[$username], Group[$username], File[$approot] ],
    }


    # make sure that we back up the DB
    backups::dir { 'sanitationcompass_db':
        path => "${approot}/db"
    }

    # include the script for downloading and creating an app
    file { "${approot}/make_app.sh":
        ensure  => present,
        content => template('sanitationcompass/make_app.sh.erb'),
        owner   => $username,
        group   => $username,
        mode    => '0744',
        require => File[$approot]
    }

    # include the script for switching the app
    file { "${approot}/make_current.sh":
        ensure  => present,
        content => template('sanitationcompass/make_current.sh.erb'),
        owner   => $username,
        group   => $username,
        mode    => '0744',
        require => File[$approot]
    }

    # include the script for switching the app
    file { "${approot}/update_current.sh":
        ensure  => present,
        content => template('sanitationcompass/update_current.sh.erb'),
        owner   => $username,
        group   => $username,
        mode    => '0744',
        require => File[$approot]
    }

    # include the script for cleaning up old versions
    file { "${approot}/cleanup_old.sh":
        ensure  => present,
        content => template('sanitationcompass/cleanup_old.sh.erb'),
        owner   => $username,
        group   => $username,
        mode    => '0744',
        require => File[$approot]
    }

}