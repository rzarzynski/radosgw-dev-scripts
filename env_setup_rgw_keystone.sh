#!/bin/bash

# The script should be sourced into current env.

source $(dirname ${BASH_SOURCE[0]})/config-${CONF:-def}.sh

echo "Getting token for account: ${KEYSTONE_ACCT}"

response=$(
    curl ${KEYSTONE_URL}                                        \
        -s                                                      \
        -H "Content-type: application/json"                     \
        -d "{
                 \"auth\": {
                     \"passwordCredentials\": {
                         \"username\": \"${KEYSTONE_USER}\",
                         \"password\": \"${KEYSTONE_PASS}\"
                     },
                     \"tenantName\"  : \"${KEYSTONE_ACCT}\"
                 }
             }"
)

token=$(
    echo $response                                          \
    |                                                       \
    python -c 'import json, sys; obj=json.load(sys.stdin); print obj["access"]["token"]["id"]'
)

publicURL=$(
    echo $response                                          \
    |                                                       \
    python -c 'import json, sys; obj=json.load(sys.stdin); print obj["access"]["serviceCatalog"][0]["endpoints"][0]["publicURL"]'
)

export token
export publicURL
