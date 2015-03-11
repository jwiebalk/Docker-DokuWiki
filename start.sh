#!/bin/bash

usage() { cat << EOF
Usage: docker run wolfador/dokuwiki [opts]

Run a dokuwiki httpd container.

    -? | -h | -help | --help            print this help

EOF
}

while true ; do
  case "$1" in
    -?|-h|-help|--help)
      usage
      exit 0
      ;;

    "")
      break
      ;;

    *)
      usage > /dev/stderr
      exit 1
      ;;
  esac
done

set -x

# --------------------------------------------------------------------------------------------------
# preparation
# --------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------
# services
# --------------------------------------------------------------------------------------------------

#service httpd start

apachectl -d . -f /etc/httpd/conf/httpd.conf -e info -DFOREGROUND


