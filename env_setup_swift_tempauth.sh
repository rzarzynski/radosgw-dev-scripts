# The script should be sourced into current env.

source config.sh

response=$( curl -i -H  X-Auth-User:${TEMPAUTH_USER}:${TEMPAUTH_ACCT}   \
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
