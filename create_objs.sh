#!/bin/sh

curl -i ${publicURL}/cont -X PUT -H "X-Auth-Token: ${token}"

#curl -i http://localhost:8080/swift/v1/cont/aaa10 -X PUT -H "X-Auth-Token: $token" -H "Content-Length: 0"
#curl -i http://localhost:8080/swift/v1/cont/obj10 -X PUT -H "X-Auth-Token: $token" -H "Content-Length: 0"
#curl -i http://localhost:8080/swift/v1/cont/obj15 -X PUT -H "X-Auth-Token: $token" -H "Content-Length: 0"
#curl -i http://localhost:8080/swift/v1/cont/obj12 -X PUT -H "X-Auth-Token: $token" -H "Content-Length: 0"

curl -i ${publicURL}/cont/aaa10 -X PUT -H "X-Auth-Token: ${token}" -d ''
curl -i ${publicURL}/cont/obj10 -X PUT -H "X-Auth-Token: ${token}" -d ''
curl -i ${publicURL}/cont/obj15 -X PUT -H "X-Auth-Token: ${token}" -d ''
curl -v ${publicURL}/cont/obj12 -X PUT -H "X-Auth-Token: ${token}" -d ''
