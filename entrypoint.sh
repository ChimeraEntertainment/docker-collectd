#!/bin/bash

set -e

if [ -n "$COLLECTD_HOSTNAME" ]; then
  sed -i "/#Hostname/c\Hostname    \"${COLLECTD_HOSTNAME}\"" /etc/collectd/collectd.conf
fi

if [ -d /mnt/proc ]; then
  umount /proc
  mount -o bind /mnt/proc /proc
fi

if [ -z "$@" ]; then
  exec /usr/sbin/collectd -C /etc/collectd/collectd.conf -f
else
  exec $@
fi
