#!/bin/bash -e
if [ ! -O /config ]
then
  usermod -u "$(stat -c %u /config)" plex
fi
/usr/bin/supervisord -c /etc/supervisord.conf "$@"
