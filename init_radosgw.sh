#!/bin/bash

if [ "${PWD##*/}" == "build" ]
then
  BINDIR="bin"
else
  BINDIR="."
fi

${BINDIR}/ceph-authtool     --create-keyring            \
                            ./ceph.client.radosgw.keyring

${BINDIR}/ceph-authtool -n client.radosgw.gateway       \
                        --gen-key                       \
                        ./ceph.client.radosgw.keyring

${BINDIR}/ceph-authtool -n client.radosgw.gateway       \
                        --cap osd 'allow rwx'           \
                        --cap mon 'allow rwx'           \
                        ./ceph.client.radosgw.keyring
