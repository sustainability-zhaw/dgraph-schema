#!/bin/sh

# clear the database from dummies
curl -X POST ${DGRAPH_SERVER}/alter -d '{"drop_op": "DATA"}'

# Install the schema 
curl -X POST \
     ${DGRAPH_SERVER}/admin/schema \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/schema.graphql'

# Insert Constants
curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/constants.graphql'
