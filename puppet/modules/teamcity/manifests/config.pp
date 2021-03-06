
class teamcity::config {

    $listen_address = '127.0.0.1'
    file { '/opt/teamcity/TeamCity/conf/server.xml':
        ensure  => present,
        owner   => teamcity,
        group   => teamcity,
        content => template('teamcity/server.xml.erb'),
        mode    => '0644'
    }

    file { '/opt/teamcity/.BuildServer/config':
        ensure => directory,
        owner  => teamcity,
        group  => teamcity,
        mode   => '0755',
    }

    $mysql_name = hiera('teamcity_mysql_name', 'mysql')
    $base_domain = hiera('base_domain')
    $teamcity_database_host = "${mysql_name}.${base_domain}"
    $teamcity_database_password = hiera('teamcity_database_password')
    file { '/opt/teamcity/.BuildServer/config/database.properties':
        ensure  => present,
        owner   => teamcity,
        group   => teamcity,
        content => template('teamcity/database.properties.erb'),
        mode    => '0644',
        require => File['/opt/teamcity/.BuildServer/config'],
    }

    named::service_location { 'ci':
        ip => hiera('external_ip')
    }
}