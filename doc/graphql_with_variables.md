## calling graphql statements with JSON variables

Much nicer than the hard coded data. Much easier to implement on the client.

### HTTP Body

```
curl -s \
     -H "Content-Type: application/json" \
     -X POST \
     localhost:8080/graphql \
     --data '@examples/with_variables.graphql' \
| jq .data
```

> Warning: The content type MUST be `application/json`!

The variables are then provided as a JSON object as such: 

```json
{
    "query": "mutation addSdgMatch($matcher: [AddSdgMatchInput!]!) { addSdgMatch(input: $matcher) { sdgMatch { construct } } }",
    "variables": {
        "matcher":[ 
            {
              "construct": "sdg16_c86_de",
              "language": "de",
              "keyword": "Freiheit der Rede",
              "required_context": ""
            },
            {
              "construct": "sdg16_c86_fr",
              "language": "fr",
              "keyword": "liberté d'expression",
              "required_context": ""
            }
        ]
    }
}
```

For initialising the variables the `add`-operation must be provided, twice. 

The first (outer) operation assigns the *operation input*. During this step it is necessary for assigning the correct variable *input type* to the operation. The correct input type is constructed by capitalising the operation and add `Input` as suffix. In the given example the operation is `addSdgMatch`. Therefore, the input type is `AddSdgMatchInput`. 

The second (inner) part of the operation uses the variable as input. Note that the variable must be prefixed *perl4*/*php*-style with a dollar sign. The dollar sign MUST be absent in the variable declaration in the `variables`-part. 

## DQL with GraphQL Variables.

The same can be applied to Dgraph's own DQL system. 

Again, the query is constructed as a string. Then the variables are constructed as an object, which attributes can be accessed from within the query. Like in GraphQL the query requires an additional outer element that declares the variables. 

This could  simplify the DQL query statements.

The [documentation](https://dgraph.io/docs/query-language/graphql-variables/) is unclear whether the dollar sign is needed in the variables object as well. 
