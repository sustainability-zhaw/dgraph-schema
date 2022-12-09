# Dgraph

Dgraph needs a Schema to operate. 

Because the database sits behind the proxy and does not expose the ports, we need a helper container to initialise the database.

To install or update a schema: 

```
curl -X POST http://localhost:8080/admin/schema --data-binary '@schema/dgraph_schema.graphql'
```

When installing a fresh schema, the constants are also important

```
curl -s -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@schema/constants.graphql'
```

Insert data works as follows: 

This will insert a working dataset for the UI. 

```
curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@sampledata/people.graphql'

curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@sampledata/pubs.graphql'
```

To test the process, the following call inserts just scraping data and leave persons empty. This is useful to test the LDAP lookup process.

```
curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@sampledata/pubs.graphql'
```

Get data: 

```
curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@dummy/getusers.graphql'
```

Reset the entire database - including the schema: 

```
curl -X POST localhost:8080/alter -d '{"drop_op": "DATA"}'
```


Deleting individual Data: 

```
mutation {
  deletePerson(filter: {
    xid: { eq: "karl" }
  }) {
    person {
      xid
      name
      age
    }
  }
}
```
