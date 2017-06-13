#!/bin/bash
set -e

if [ "${PWD##*/}" == "build" ]
then
  BINDIR="bin"
else
  BINDIR="."
fi

${BINDIR}/radosgw-admin user create                             \
                --uid="test"                                    \
                --display-name="John Doe"                       \
                --email="john@example.com"                      &&
${BINDIR}/radosgw-admin subuser create                          \
                --uid="test"                                    \
                --subuser="test:tester"                         \
                --access=full                                   &&
${BINDIR}/radosgw-admin key create                              \
                --subuser="test:tester"                         \
                --key-type=swift                                \
                --secret="testing"
