#!/bin/sh

curl -i ${publicURL}/swsc       -X PUT -H "X-Auth-Token: ${token}"

curl -i ${publicURL}/swsc       -X POST -H "X-Auth-Token: $token"  \
     -H "X-Container-Meta-Web-Listings-CSS: styles.css"            \
     -H "X-Container-Meta-Web-Listings: true"                      \
     -H "X-Container-Meta-Web-Index: index.html"                   \
#     -H "X-Container-Meta-Web-Index;"                              \
     -H "X-Container-Meta-Web-Error: error.html"

# General index page
curl -i ${publicURL}/swsc/index.html   -X PUT -H "X-Auth-Token: ${token}" \
     -d 'an index object'

# Subdir index page
curl -i ${publicURL}/swsc/dir/index.html   -X PUT -H "X-Auth-Token: ${token}" \
     -d 'a SUBDIR index object'

# Sub-subdir index page
curl -i ${publicURL}/swsc/dir/sdir/index.html   -X PUT -H "X-Auth-Token: ${token}" \
     -d 'a SUB-SUBDIR index object'

# Error page
curl -i "$publicURL/swsc/404error.html" -X PUT -H "X-Auth-Token: $token" -d "This is 404
error
"

curl -i ${publicURL}/swsc/obj   -X PUT -H "X-Auth-Token: ${token}" \
     -d 'a regular object'

# Directory markers
curl -i ${publicURL}/swsc/dir   -X PUT -H "X-Auth-Token: ${token}" \
     -d '' -H "Content-Type: application/directory"

curl -i ${publicURL}/swsc/dir/sdir   -X PUT -H "X-Auth-Token: ${token}" \
     -d '' -H "Content-Type: application/directory"

# Subdir's content
curl -i ${publicURL}/swsc/dir/a -X PUT -H "X-Auth-Token: ${token}" \
     -d 'object a'
curl -i ${publicURL}/swsc/dir/b -X PUT -H "X-Auth-Token: ${token}" \
     -d 'object b'
curl -i ${publicURL}/swsc/dir/c -X PUT -H "X-Auth-Token: ${token}" \
     -d 'object c'


curl -X GET -H "X-Auth-Token: $token" "$publicURL/swsc/?format=json" -H "X-Web-Mode: true"

