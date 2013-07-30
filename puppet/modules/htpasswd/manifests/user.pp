
define htpasswd::user ($user, $role, $password) {

    include htpasswd::fs

    file_line { "htpasswd-${user}-${role}":
        path    => "/etc/htpasswd/${role}",
        line    => inline_template("${user}:${password}"),
        require => File['/etc/htpasswd/']
    }

}