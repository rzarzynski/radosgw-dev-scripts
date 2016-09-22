#!/bin/bash
set -e

if [ "${PWD##*/}" == "build" ]
then
  BINDIR="bin"
else
  BINDIR="."
fi

STATICS=$(dirname ${BASH_SOURCE[0]})/statics

${BINDIR}/ceph auth add client.radosgw.gateway -i ./ceph.client.radosgw.keyring

if [ ! -f ceph-rgw.conf ]; then
    cp -f ${STATICS}/ceph-rgw.conf ./
fi

exec ${BINDIR}/radosgw -n client.radosgw.gateway -c ./ceph-rgw.conf \
                       --rgw_socket_path /tmp/rgw.fcgi.sock \
                       -d $@

# Keystone v3
# ../../radosgw-dev-scripts/start_radosgw.sh -d --debug_rgw 20 --rgw_swift_enforce_content_length true --rgw_keystone_admin_domain "Default" --rgw_keystone_api_version 3 --rgw_keystone_admin_project "admin"
