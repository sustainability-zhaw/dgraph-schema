#!/bin/bash

# Allow dgraph to initialize
sleep 20

echo clear the database

curl -s -X POST ${DGRAPH_SERVER}/alter -d '{"drop_op": "DATA"}'

echo
echo Install the schema 

curl -s -X POST \
     ${DGRAPH_SERVER}/admin/schema \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/schema.graphql'

echo
echo Insert Constants

curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/constants.graphql'

if [[ ! -z $SAMPLE_DATA ]]
then
    # 
    echo
    echo insert sample data

    FILE="/data/sampledata/${SAMPLE_DATA}.graphql"

    echo $FILE

    if [[ -f $FILE ]]
    then
        curl -s -X POST \
         ${DGRAPH_SERVER}/graphql \
         -H 'Content-Type: application/graphql' \
         --data-binary "@$FILE"
    else
        echo "Sample data not found!"
    fi
fi