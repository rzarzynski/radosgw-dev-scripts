#!/bin/bash
#
# Script to run Tempest's test for verifying radosgw compliance
# with Swift API (a.k.a OpenStack Object Storage API v1).
set -ex

KEYSTONE_IP=127.0.0.1
KEYSTONE_PORT=5000
KEYSTONE_PORT_ADMIN=35357

RADOSGW_URL=http://127.0.0.1:8000/swift/v1

get_id()
{
  echo `"$@" | grep ' id ' | awk '{print $4}'`
}

keystone_put_authinfo()
{
  export OS_AUTH_URL="http://${KEYSTONE_IP}:${KEYSTONE_PORT}/v2.0/"
  export SERVICE_ENDPOINT="http://${KEYSTONE_IP}:${KEYSTONE_PORT_ADMIN}/v2.0/"
  export SERVICE_TOKEN=ADMIN

  # tenants
  keystone tenant-create \
                            --name admin \
                            --description "Admin Tenant"

  keystone tenant-create \
                            --name tempest \
                            --description "Tempest"

  # users
  keystone user-create \
                            --name admin \
                            --pass ${SERVICE_TOKEN}

  keystone user-create \
                            --name tempest_u1 \
                            --pass tempest \
                            --tenant-id tempest

  keystone user-create \
                            --name tempest_u2 \
                            --pass tempest \
                            --tenant-id tempest

  # roles
  keystone role-create \
                            --name admin

  keystone role-create \
                            --name Member

  # users privileges
  keystone user-role-add \
                            --user-id admin \
                            --role-id admin \
                            --tenant-id admin

  keystone user-role-add \
                            --user-id tempest_u1 \
                            --role-id Member \
                            --tenant-id tempest

  keystone user-role-add \
                            --user-id tempest_u2 \
                            --role-id Member \
                            --tenant-id tempest

  # keystone service
  keystone service-create \
                            --name keystone \
                            --type identity \
                            --description "Keystone Identity Service"

  keystone endpoint-create \
                            --region RegionOne \
                            --service-id keystone \
                            --publicurl "http://127.0.1:\$(public_port)s/v2.0" \
                            --adminurl "http://127.0.0.1:\$(admin_port)s/v2.0" \
                            --internalurl "http://127.0.0.1:\$(public_port)s/v2.0"

  # object store service
  keystone service-create \
                            --name swift \
                            --type "object-store" \
                            --description "Swift Service"

  keystone endpoint-create \
                            --region RegionOne \
                            --service-id swift \
                            --publicurl "${RADOSGW_URL}" \
                            --adminurl "${RADOSGW_URL}" \
                            --internalurl "${RADOSGW_URL}"
}

keystone_put_authinfo
