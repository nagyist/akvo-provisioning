
class teamcity {

    class { 'teamcity::packages': } ->
    class { 'teamcity::user': } ->
    class { 'teamcity::install': } ->
    class { 'teamcity::database': } ->
    class { 'teamcity::config': } ~>
    class { 'teamcity::reload': } ~>
    class { 'teamcity::service': }

}
