#!/bin/sh

DGRAPH_SERVER="http://dgraph_standalone:8080"

# clear the database from dummies
curl -X POST ${DGRAPH_SERVER}/alter -d '{"drop_op": "DATA"}'

# Install the schema 
curl -X POST ${DGRAPH_SERVER}/admin/schema --data-binary '@/data/schema/schema.graphql'

# Insert Constants
curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/constants.graphql'

## 
# The following injects dummy data for seeding the database for 
# demonstration purposes
# 

# Insert Dummy Records
if [ -f "/data/schema/persons.graphql" ]
then
    curl -s -X POST \
         ${DGRAPH_SERVER}/graphql \
         -H 'Content-Type: application/graphql' \
         --data-binary '@/data/schema/persons.graphql'
fi

if [ -f "/data/schema/publications.graphql" ]
then
curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/publications.graphql'
fi
