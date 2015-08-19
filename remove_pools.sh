#!/bin/sh
set -e

RGW_POOLS=".rgw.root .rgw.control .rgw .rgw.gc .users.uid .rgw.buckets.index .rgw.buckets .intent-log"

for pool in ${RGW_POOLS}
do
    ceph osd pool delete ${pool} ${pool} --yes-i-really-really-mean-it
done
