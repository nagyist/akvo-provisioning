# Base parameters for Keycloak manifest

class keycloak::params {

  $base_domain         = hiera('base_domain')
  $ip                  = hiera('external_ip')
  $psql_name           = hiera('keycloak_psql_name', 'psql')
  $ssl_cert_source     = hiera('akvo_wildcard_cert')
  $ssl_key_source      = hiera('akvo_wildcard_key')

  $port                = '8080'

  $db_host             = "${psql_name}.${base_domain}"
  $db_username         = 'keycloak'
  $db_name             = 'keycloak'
  $db_password         = hiera('keycloak_database_password')

  $kc_release          = '2.2.0.Final'
  $approot             = '/opt/keycloak'
  $appdir              = "${approot}/keycloak-${kc_release}"

  $psql_driver_release = '9.4.1210.jre7'

}
