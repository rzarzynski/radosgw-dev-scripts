#!/bin/bash
set -e

if [ "${PWD##*/}" == "build" ]
then
  BINDIR="bin"
else
  BINDIR="."
fi

# The first credential for both manual testing and the Functional
# Tests of Swift
${BINDIR}/radosgw-admin user create                             \
                --uid="test"                                    \
                --tenant="test"                                 \
                --display-name="John Doe"                       \
                --email="john@example.com"                      &&
${BINDIR}/radosgw-admin subuser create                          \
                --uid="test"                                    \
                --tenant="test"                                 \
                --subuser="test:tester"                         \
                --access=full                                   &&
${BINDIR}/radosgw-admin key create                              \
                --uid="test"                                    \
                --tenant="test"                                 \
                --subuser="test:tester"                         \
                --key-type=swift                                \
                --secret="testing"

# The second credentuals solely for the functional tests
${BINDIR}/radosgw-admin user create                             \
                --uid="test2"                                   \
                --tenant="test2"                                \
                --display-name="John Doe 2"                     \
                --email="john2@example.com"                     &&
${BINDIR}/radosgw-admin subuser create                          \
                --uid="test2"                                   \
                --tenant="test2"                                \
                --subuser="test2:tester2"                       \
                --access=full                                   &&
${BINDIR}/radosgw-admin key create                              \
                --uid="test2"                                   \
                --tenant="test2"                                \
                --subuser='test2:tester2'                       \
                --key-type=swift                                \
                --secret="testing2"
