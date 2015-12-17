#!/bin/bash

# The script should be sourced into current env.

source $(dirname ${BASH_SOURCE[0]})/config-${CONF:-def}.sh

response=$( curl -i -H  X-Auth-User:${TEMPAUTH_ACCT}:${TEMPAUTH_USER}   \
                    -H  X-Auth-Key:${TEMPAUTH_PASS}                     \
                    ${TEMPAUTH_URL}                                     \
            | tr -d '\r')

publicURL=$(echo "${response}"                                          \
            | grep X-Storage-Url                                        \
            | cut -d " " -f 2)

token=$(    echo "${response}"                                          \
            | grep X-Auth-Token                                         \
            | cut -d " " -f 2)

export publicURL
export token
