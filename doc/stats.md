## Stats

> The stats cannot get implemented in graphQL directly because GQL does not provide mechanisms for aggregate functions. dgraph provides simple counts aggregations, but these aggregations will only consider one edge of the graph. 

Four statistics are relevant to us: 

- The number of entries per publication type ()
- The number of entries in SDGs
- The number of entries per Department 
- The number of entries per person

All stats are basic counts. 

The number of entries per publication type is the initial value to be determined: It contains the core numbers in the entire system. 

Then a user will focus on a chosen type of information object. Therefore, the statistics should narrow towards the chosen publication type. This affects the SDG and Department counts. 

These numbers are fixed to 16 SDG and 8 Departments. For each publication type this value should be prefetched for each query

For publications and projects the last statistic is needed: the per person statistic. This gives the number of records per chosen person. This number can be very large and **must** use paginated retrieval! 

### Groupby

dgraph's DQL has a group by clause. This clause should be used for handling the different InfoObjectTypes.

### Filtered stats

Filtered stats should first filter the objects and then run the stats on these objects.
