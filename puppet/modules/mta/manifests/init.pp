
class mta {

    package { ['postfix', 'mailutils']:
        ensure => installed,
    }

    package { 'sendmail':
        ensure => absent
    }

    $base_domain = hiera('base_domain')
    file { '/etc/postfix/main.cf':
        ensure  => present,
        mode    => '0444',
        owner   => 'root',
        content => template('mta/main.cf.erb'),
        require => Package['postfix']
    }

}
