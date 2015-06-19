#!/bin/sh

# The script should be sourced into current env.

source config.sh

token=$(
    curl -d "{
                 \"auth\": {
                     \"passwordCredentials\": {
                         \"username\": \"${KEYSTONE_USER}\",
                         \"password\": \"${KEYSTONE_PASS}\"
                     },
                     \"tenantName\"  : \"${KEYSTONE_PASS}\"
                 }
             }"                                             \
         -H "Content-type: application/json"                \
         ${KEYSTONE_URL}                                    \
    |                                                       \
    python -c 'import json, sys; obj=json.load(sys.stdin); print obj["access"]["token"]["id"]'
)
publicURL=http://localhost:8080/swift/v1

export token
export publicURL
