
define backups::server (
    $username,
    $remote_host, $dest_dir,
    $host_key = undef,
    $password = undef,
    $host_key_type = 'rsa', $port = 22, $use_sftp = false
) {

    notice("Backup server: ${name}")

    file { "/backups/bin/diff_backup_to_${name}.sh":
        ensure  => present,
        owner   => 'backup',
        mode    => '0740',
        content => template('backups/diff_copy.sh.erb'),
        require => [Exec['clean_up_backup_config'], File['/backups/bin']]
    }

    file { "/backups/bin/plain_backup_to_${name}.sh":
        ensure  => present,
        owner   => 'backup',
        mode    => '0740',
        content => template('backups/plain_copy.sh.erb'),
        require => [Exec['clean_up_backup_config'], File['/backups/bin']]
    }

    if $host_key {
        sshkey { "backup-server-${name}":
            ensure => present,
            name   => $remote_host,
            type   => $host_key_type,
            key    => $host_key
        }
    }

}