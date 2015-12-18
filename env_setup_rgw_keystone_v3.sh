#!/bin/bash

# The script should be sourced into current env.

source $(dirname ${BASH_SOURCE[0]})/config-${CONF:-def}.sh

echo "Getting token for account: ${KEYSTONE_ACCT}"

response=$(
    curl ${KEYSTONE_URL_V3}                                     \
        -i                                                      \
        -s                                                      \
        -H "Content-type: application/json"                     \
        -d "{
        \"auth\": {
            \"identity\": {
                \"methods\": [
                    \"password\"
                ],
                \"password\": {
                    \"user\": {
                        \"domain\": {
                            \"name\": \"Default\"
                        },
                        \"name\": \"${KEYSTONE_USER}\",
                        \"password\": \"${KEYSTONE_PASS}\"
                    }
                }
            },
            \"scope\": {
                \"project\": {
                    \"domain\": {
                        \"name\": \"Default\"
                    },
                    \"name\": \"${KEYSTONE_ACCT}\"
                }
            }
        }
    }"
)

body=$(
    echo "${response}"                                          \
    |                                                           \
    sed '1,/^\r\{0,1\}$/d'
)

token=$(
    echo "${response}"                                          \
    |                                                           \
    grep ^X-Subject-Token: | awk '{print $2}'
)

publicURL=$(
    echo "${body}"                                              \
    |                                                           \
    python -c 'import json, sys; obj=json.load(sys.stdin); print obj["token"]["catalog"][1]["endpoints"][1]["url"]'
)

echo ${body} | python -m json.tool

export token
export publicURL
