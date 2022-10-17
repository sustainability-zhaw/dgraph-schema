#!/bin/sh

DGRAPH_SERVER="http://dgraph_standalone:8080"

# Install the schema 
curl -s -X POST ${DGRAPH_SERVER}/admin/schema --data-binary '@/data/schema/schema.graphql'

# Insert Constants
# curl -s -X POST \
#      ${DGRAPH_SERVER}/graphql \
#      -H 'Content-Type: application/graphql' \
#      --data-binary '@/data/schema/constants.graphql' \

