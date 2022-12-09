# Person Schema

The person schema links the database with the Active directory. Therefore the DN is mandatory when referring to a person during updates or additions. 

The following mappings apply.

| AD | Dgraph Schema |
| :--- | :--- |
| `dn` | `LDAPDN` | 
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

The internal data structure is defined as: 

```graphql
type Author {
    fullname: String! @id @search(by: [term]) # this field is set by publications.
    person: [ Person ]                        # empty if author is not in AD
    ad_check: Int @search                     # timestamp of last AD check, 0 or unset to recheck if author is now in or outof AD
}

type Person {
    fullname: String! @search(by: [term])
    initials: String @search(by: [exact])
    surname: String  @search(by: [term])
    givenname: String
    displayname: String
    gender: String
    title: String
    mail: String
    ipphone: String
    physicaldeliveryofficename: String
    team: Team
    manager: Person @hasInverse(field: directreports)
    department: Department
    objects: [ InfoObject ] @hasInverse(field: persons)
    LDAPDN: String @id @search(by: [exact])
    directreports: [ Person ] @hasInverse(field: manager)
    ad_check: Int @search # 0 or NULL to force AD update
}
```

A team is an LDAPDN to an organisational structure. This allows to link all people from the same unit. Currently unused.

Persons are embedded into line management. 

Persons have one manager and may have several subordinates (direct reports).
