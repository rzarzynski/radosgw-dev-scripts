#!/bin/sh

./ceph-authtool --create-keyring                \
                ./ceph.client.radosgw.keyring

./ceph-authtool -n client.radosgw.gateway       \
                --gen-key                       \
                ./ceph.client.radosgw.keyring

./ceph-authtool -n client.radosgw.gateway       \
                --cap osd 'allow rwx'           \
                --cap mon 'allow rwx'           \
                ./ceph.client.radosgw.keyring
