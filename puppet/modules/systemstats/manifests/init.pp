
class systemstats {

    user { 'stats':
        ensure => present,
        shell  => '/bin/bash',
        home   => '/var/stats',
    }

    group { 'stats':
        ensure => present,
    }

    file { ['/var/stats', '/var/stats/bin/']:
        ensure  => directory,
        owner   => 'stats',
        mode    => '755',
        require => User['stats'],
    }

    $statsd_host = hiera('statsd_host')
    file { '/usr/local/bin/sendstat':
        ensure  => present,
        owner   => 'root',
        mode    => '0755',
        content => template('systemstats/send_stat.sh.erb')
    }

    systemstats::stat { [
        'packages_available',
        'restart_required',
    ]:
        user    => 'root',
        require => File['/usr/local/bin/sendstat']
    }

}