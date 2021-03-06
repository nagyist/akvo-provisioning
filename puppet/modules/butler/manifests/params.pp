
class butler::params {
    
    # some shared config
    $username = 'butler'
    $dbname = $username
    $approot = '/var/akvo/butler'
    $database_password = hiera('butler_database_password')
    $base_domain = hiera('base_domain')
    $puppetdb_server = hiera('puppetdb_server')
    $puppetdb_url = "https://${puppetdb_server}"
    $mysql_name = hiera('butler_mysql_name', 'mysql')
    $database_host = "${mysql_name}.${base_domain}"
    $database_url = "mysql://${username}:${database_password}@${database_host}/${dbname}"
    $media_root = "${approot}/mediaroot/"
    $logdir = "${approot}/logs/"
    $port = 8010
    $butler_debug = hiera('butler_debug', false)
    $butler_secret_key = hiera('butler_secret_key')
    $debug = hiera('butler_debug', false)
    $butler_hosts = hiera('butler_hosts', ["butler.${base_domain}"])

    $env_vars = {
        'DEBUG'                  => $debug,
        'DJANGO_SETTINGS_MODULE' => 'butler.settings',
        'SECRET_KEY'             => hiera('butler_secret_key'),
        'PUPPETDB_URL'           => $puppetdb_url,
        'DATABASE_URL'           => $butler::params::database_url,
        'BUTLER_PUPPETDB_KEY'    => "${approot}/ssl/puppetdb_key",
        'BUTLER_PUPPETDB_CERT'   => "${approot}/ssl/puppetdb_cert",
        'STATIC_ROOT'            => "${media_root}/static",
        'MEDIA_ROOT'             => "${media_root}/media",
        'ALLOWED_HOSTS'          => join($butler_hosts, ','),
        'CACHE_BACKEND'          =>'django.core.cache.backends.memcached.MemcachedCache',
        'CACHE_LOCATION'         => '127.0.0.1:11211'
    }

}