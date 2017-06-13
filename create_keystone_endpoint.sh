#!/bin/sh
# http://127.0.0.1:8000/swift/v1/KEY_$(tenant_id)s

#keystone_url='http://127.0.0.1:8000/swift/v1'
#keystone_url='http://127.0.0.1:8000/v1'
#keystone_url='http://127.0.0.1:7070/swift/v1/KEY_$(tenant_id)s'
#keystone_url='http://127.0.0.1:8000/swift/v1/KEY_$(tenant_id)s'
#keystone_url='http://127.0.0.1:8002/swift/v1/KEY_$(tenant_id)s'
keystone_url='http://127.0.0.1:8000/v1/KEY_$(tenant_id)s'
#keystone_url='http://127.0.0.1:8002/v1/KEY_$(tenant_id)s'
#keystone_url='http://127.0.0.1:7070/v1/KEY_$(tenant_id)s'

keystone endpoint-create --service-id ab5931782d9147499663a6bfdccc7b4b  \
                         --publicurl "${keystone_url}"                  \
                         --internalurl "${keystone_url}"                \
                         --adminurl "${keystone_url}"

#keystone endpoint-create --service-id 88e3625add5d4630adcfe2223fd33ea2  \
#                         --publicurl 'http://127.0.1:$(public_port)s/v2.0'                  \
#                         --internalurl 'http://127.0.0.1:$(public_port)s/v2.0'                \
#                         --adminurl 'http://127.0.0.1:$(admin_port)s/v2.0'
