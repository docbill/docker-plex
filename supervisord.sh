#!/bin/bash -e
if [ ! -O /config ]
then
  usermod -u "$(stat -c %u /config)" plex
fi
exec /usr/bin/supervisord -c "$@"

