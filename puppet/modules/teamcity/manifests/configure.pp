
class teamcity::configure {

    $listen_address = '127.0.0.1'
    file { '/opt/teamcity/TeamCity/conf/server.xml':
        ensure  => present,
        owner   => teamcity,
        group   => teamcity,
        content => template('teamcity/server.xml.erb'),
        mode    => 644
    }

    file { '/opt/teamcity/.BuildServer/config':
        ensure => directory,
        owner  => teamcity,
        group  => teamcity,
        mode   => 755,
    }

    $teamcity_database_password = hiera('teamcity_database_password')
    file { '/opt/teamcity/.BuildServer/config/database.properties':
        ensure  => present,
        owner   => teamcity,
        group   => teamcity,
        content => template('teamcity/database.properties.erb'),
        mode    => 644,
        require => File['/opt/teamcity/.BuildServer/config'],
    }

}