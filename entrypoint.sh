#!/bin/bash

# Allow dgraph to initialize
echo "prepare db init"

if [[ ! -z $TIMEOUT ]]
then
    TIMEOUT=20
fi

echo "wait for the DB to initialise for $TIMEOUT seconds"

sleep $TIMEOUT

if [[ ! -z $FORCE_RESET ]]
then
    echo "clear the database"

    curl -s -X POST ${DGRAPH_SERVER}/alter -d '{"drop_op": "DATA"}'
fi

echo
echo "Install the schema "

curl -s -X POST \
     ${DGRAPH_SERVER}/admin/schema \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/schema.graphql'

echo
echo "Insert Constants"

curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/constants.graphql'

if [[ ! -z $SAMPLE_DATA ]]
then
    echo
    echo "insert sample data"

    FILE="/data/sampledata/${SAMPLE_DATA}.graphql"

    echo "load file $FILE"

    if [[ -f $FILE ]]
    then
        curl -s -X POST \
         ${DGRAPH_SERVER}/graphql \
         -H 'Content-Type: application/graphql' \
         --data-binary "@$FILE"
    else
        echo "Sample data not found!"
    fi
    echo
fi