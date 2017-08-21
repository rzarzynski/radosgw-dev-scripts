#!/bin/bash
set -e

if [ "${PWD##*/}" == "build" ]
then
  BINDIR="bin"
else
  BINDIR="."
fi

VALGRIND="valgrind --trace-children=no --child-silent-after-fork=yes --num-callers=50  --xml=yes --xml-file=/tmp/ceph.client.0.log --time-stamp=yes --tool=memcheck"
STATICS=$(dirname ${BASH_SOURCE[0]})/statics

${BINDIR}/ceph auth add client.radosgw.gateway -i ./ceph.client.radosgw.keyring

if [ ! -f ceph-rgw.conf ]; then
    cp -f ${STATICS}/ceph-rgw.conf ./
fi

exec ${VALGRIND} ${BINDIR}/radosgw -n client.radosgw.gateway -c ./ceph-rgw.conf \
                       --rgw_socket_path /tmp/rgw.fcgi.sock \
                       -d $@

# Keystone v3
# ../../radosgw-dev-scripts/start_radosgw.sh -d --debug_rgw 20 --rgw_swift_enforce_content_length=true --rgw_keystone_admin_domain "Default" --rgw_keystone_api_version 3 --rgw_keystone_admin_project "admin"

# New auth
# ../../radosgw-dev-scripts/start_radosgw.sh -d --debug_rgw 20 --rgw_swift_enforce_content_length=true --rgw_swift_account_in_url=true --rgw_keystone_implicit_tenants=true --rgw_keystone_accepted_admin_roles "admin"

# Full Swift
# ../../radosgw-dev-scripts/start_radosgw.sh -d --debug_rgw 20 --rgw_swift_enforce_content_length=true --rgw_swift_account_in_url=true --rgw_keystone_implicit_tenants=true --rgw_keystone_accepted_admin_roles "admin" --rgw_swift_versioning_enabled=true
