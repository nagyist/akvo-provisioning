class bind {

    # get some environment specific vars
    $zone = hiera('base_domain')
    $zonefile = "/srv/bind/db.${zone}"
    $managementip = hiera('management_server_ip')
    $dnsip = $managementip

    # install bind and make sure puppet keeps the service alive
    package { 'bind9':
        ensure => installed,
    }
  
    service { 'bind9':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => File['/etc/bind/named.conf.local'],
    }

    # create a place for our custom config, outside of the default package
    # paths to make them independent of bind
    file { '/srv/bind':
        ensure  => directory,
        owner   => "bind",
        group   => "bind",
        mode    => 750,
        require => Package['bind9'],
    }

    # configure the list of zones we will manage
    file { '/etc/bind/named.conf.local':
        ensure  => present,
        owner   => 'bind',
        group   => 'bind',
        mode    => 644,
        content => template('bind/named.conf.local.erb'),
        require => Package['bind9'],
    }


    # configure our default management server zone file
    file { $zonefile:
        ensure  => present,
        content => template('bind/envzone.erb'),
        owner   => 'bind',
        group   => 'bind',
        mode    => 644,
        require => File['/srv/bind'],
        notify  => Service['bind9']
    }

    # Collect all exported dns record file lines
    Bind::Service_Location <<| |>>


}