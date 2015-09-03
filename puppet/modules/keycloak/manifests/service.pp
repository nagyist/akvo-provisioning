# Describe Keycloak supervisord service
class keycloak::service {

  $appdir = $keycloak::appdir

  supervisord::service { 'keycloak':
    user        => 'keycloak',
    directory   => "${appdir}/bin",
    command     => "${appdir}/bin/standalone.sh",
    stopsignal  => 'KILL',
    stopasgroup => true
  }

  # The following command stops the service
  # ${appdir}/bin/jboss-cli.sh --connect command=:shutdown

}
