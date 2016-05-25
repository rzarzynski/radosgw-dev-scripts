#!/bin/sh

curl -i ${publicURL}/cont       -X PUT -H "X-Auth-Token: ${token}"

curl -i ${publicURL}/cont/aaa10 -X PUT -H "X-Auth-Token: ${token}" \
     -d '123'

# DLO/SLO's segments
curl -i ${publicURL}/cont/obj10 -X PUT -H "X-Auth-Token: ${token}" \
     -d 'abc'
curl -i ${publicURL}/cont/obj15 -X PUT -H "X-Auth-Token: ${token}" \
     -d 'ABC'
curl -i ${publicURL}/cont/obj12 -X PUT -H "X-Auth-Token: ${token}" \
     -d 'xyz'

# DLO
curl -v ${publicURL}/cont/dlo   -X PUT -H "X-Auth-Token: ${token}" \
     -d 'ok'                                                       \
     -H "X-Object-Manifest: cont/obj"

# SLO
curl -v "${publicURL}/cont/slo?multipart-manifest=put"             \
                                -X PUT -H "X-Auth-Token: ${token}" \
     -d "`cat statics/slo_manifest.txt`"

# SLO for the bug #16015
# see: http://tracker.ceph.com/issues/16015
curl -v "${publicURL}/cont/slo-16015?multipart-manifest=put"       \
                                -X PUT -H "X-Auth-Token: ${token}" \
     -d "`cat statics/slo_manifest-16015.txt`"
