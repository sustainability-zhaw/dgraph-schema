# Dgraph

Dgraph needs a Schema to operate. 

Because the database sits behind the proxy and does not expose the ports, we need a helper container to initialise the database.

To install or update a schema: 

```
curl -X POST http://localhost:8080/admin/schema --data-binary '@schema/dgraph_schema.graphql'
```


Insert data works as follows: 

```
curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@try/insertPublications.graphql'
```

Get data: 

```
curl -X POST http://localhost:8080/graphql -H 'Content-Type: application/graphql' --data-binary '@try/getusers.graphql'
```

reset the entire database 

```
curl -X POST localhost:8080/alter -d '{"drop_op": "DATA"}'
```


Deleting Data: 

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
