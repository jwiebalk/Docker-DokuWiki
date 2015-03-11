##Contains Dockuwiki / httpd / php_ldap / rsyslog

To play around with, just the default configuration and just the container:

    docker run -p 80:80 wolfador/dokuwiki_ldap

To see some container usage help:

    docker run -p 80:80 wolfador/dokuwiki_ldap

Add your configuration:

    docker run -v /path/to/data:/opt/wiki -p 80:80 wolfador/dokuwiki
