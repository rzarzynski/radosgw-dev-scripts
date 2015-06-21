#!/bin/sh

curl -i ${publicURL}/aaaa10 -X PUT -H "X-Auth-Token: ${token}"
curl -i ${publicURL}/cont10 -X PUT -H "X-Auth-Token: ${token}"
curl -i ${publicURL}/cont15 -X PUT -H "X-Auth-Token: ${token}"
curl -i ${publicURL}/cont12 -X PUT -H "X-Auth-Token: ${token}"
