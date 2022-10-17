# Person Schema

The person schema links the database with the Active directory.

The following mappings apply.

| AD | Dgraph Schema |
| :--- | :--- |
| - | `name` |
| `initials` | `initials` |
| `sn` | `surname` |
| `givenname` | `givenname` |
| `displayname` | `displayname` | 
| `extensionattribute3` | `gender` |
| `title` | `title` |
| `mail` | `mail` |
| `ipphone` | `ipphone` |
| `physicaldeliveryofficename` | `physicaldeliveryofficename` |
| `extensionattribute6` | `team` |
| `directreports` | `directreports` | 
| `manager` | `manager` |
| `department` | `department` |
| `distinguishedname` | `LDAPDN` |
