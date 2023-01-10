# dgraph-schema
A schema for the sustainability dashboard

This repository keeps the schema and the constants for ZHAW's sustainanbility dashboard. 

It is used to create a helper container for installing and/or updating the database.

## Sample Data

The following sample data is suggested to use for testing:

- plain_pubs (sampledata/plain_pubs.graphql) - minimal set as it would be produced from an OAI extraction
- pubs_and_persons (sampledata/pubs_and_persons.graphql) - fully qualified example data

## Run from `docker compose`

The following compose file will tear up a dgraph standalone instance and then install the schema and constants. Because `SAMPLE_DATA` is set, it will also inject the `plain_pubs` sample data into the database. 

```yaml
services:
  db:
    hostname: dgraph_standalone
    image: dgraph/standalone:v22.0.2
    restart: 'no'
    ports:
      - '8080:8080'
      - '9080:9080'

  db_init:
    image: ghcr.io/sustainability-zhaw/dgraph-schema:sha-d2daeec
    restart: 'no'
    environment:
      DGRAPH_SERVER: http://dgraph_standalone:8080
      SAMPLE_DATA: plain_pubs
```

`db_init` terminates after completing the entrypoint script. This allows one to use the database through the exposed hosts. 

## Example queries

Dgraph exposes two querying endpoints: 

- `/graphql` - for graphQL queries
- `/query` - for dgraph DQL queries

dgraph's native RATEL UI supports **only** DQL queries. 
