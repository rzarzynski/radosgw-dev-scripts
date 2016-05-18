#!/bin/sh

curl -i ${publicURL}/cver-store -X PUT  -H "X-Auth-Token: ${token}"
curl -i ${publicURL}/cver       -X PUT  -H "X-Auth-Token: ${token}"
curl -i ${publicURL}/cver       -X POST -H "X-Auth-Token: ${token}" \
                                        -H "X-Versions-Location: cver-store"

curl -i ${publicURL}/cver/obj   -X PUT -H "X-Auth-Token: ${token}" \
     -d '1'

curl -i ${publicURL}/cver/obj   -X PUT -H "X-Auth-Token: ${token}" \
     -d '2'
