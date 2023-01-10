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

Example queries are found in the `examples` folder. Any query file that ends on `dql` is a DQL query and needs be forwarded to the `/query` endpoint. Query files that ends on `graphql` or `gql` is a GraphQL query and has to be submitted to the `/graphql` endpoint. 

The following example uses the `examples/getsdg.graphql` file with the following contents: 

```graphql
query {
    querySdg() {
        id
        objectsAggregate {
            count
        }
    }
}
```

This query is executed with the following `curl` command. The `Content-Type`-header is required as dgraph has no automatic content type detection. Note that `-s` is just for ommitting `curl`'s progress bar.

```bash
curl -s \
     -X POST http://localhost:8080/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@examples/getsdg.graphql' 
```

In order to verify data only, the use of `jq` is recommended. To extract just the `data` portion of the previous example use:

```bash
curl -s \
     -X POST http://localhost:8080/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@examples/getsdg.graphql' \
     | jq .data
```
