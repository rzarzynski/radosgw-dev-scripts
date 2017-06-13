#!/bin/sh
set -e

./radosgw-admin quota set --quota-scope=user \
                          --uid=2987047fc47840058e89e6182e0d96c3 \
                          --max-objects=5 \
                          --max-size=10240

./radosgw-admin quota enable --quota-scope=user \
                             --uid=2987047fc47840058e89e6182e0d96c3

./radosgw-admin user info --uid=2987047fc47840058e89e6182e0d96c3
