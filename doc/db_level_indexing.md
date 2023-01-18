## Sdg indexing directly on the db
1. fetch all terms
2. Match terms with objects that were not! indexed on the term
3. If matched, add the match to the match list. 

A term is updated, by dropping the matches and then add the new version of the match. run steps 2 & 3

A match is recorded as triplet
- term
- Sdg
- Object (list)

A term has the following attributes
- id (sha1 of the other attr)
- match
- Req_Match
- Forbidden_match
- Sdg

Any match can assign only to one sdg!

Query:

- Not(uid_in(matches, uid(match.id)) AnD (alloftext(title | abstract | extras , match [And alloftext(title | abstract | extras , req-match)] [AND alloftext(title | abstract | extras , forbidden-match)] )



