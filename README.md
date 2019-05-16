## ArangoDB Dart driver

Initial implementation of an ArangoDB driver on Dart.

## Features

- Connect to ArangoDB database and execute CRUD operations on documents
- Execute AQL queries

## Limitations

Currently there is no support for graph or key values

## Instructions

```
final db = Database();
db.useBasicAuth('user', 'pass');
db.useDatabase('mydatabase');

db.query('FOR doc IN company RETURN doc')
.then((result) {
    print(result);
});

db.collection('company').byExample({'name': 'Google'})
.then((result) {
    print(result);
})

db.collection('company').import([
    {'name': 'Facebook', 'location': 'USA'},
    {'name': 'Microsoft', 'location': 'USA'}
]).then((result) {
    print(result);
});
```
