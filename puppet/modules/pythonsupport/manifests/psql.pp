# includes the system packages needed to talk to a postgres database
# server from python

class pythonsupport::psql {

  $required_packages = ['libpq-dev']

  package { $required_packages:
      ensure => 'installed'
  }

}
