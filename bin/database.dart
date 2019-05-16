import 'collection.dart';
import 'connection.dart';
import 'dart:convert';

class Database {
  Connection _connection;

  Database() {
    _connection = Connection();
  }

  Database useDatabase(String name) {
    _connection.setDatabaseName(name);
    return this;
  }

  Database useBasicAuth(String username, String password) {
    final bytes = utf8.encode('${username}:${password}');
    final base64Str = base64.encode(bytes);
    this._connection.setHeader("authorization", 'Basic $base64Str');
    return this;
  }

  Future<dynamic> query(String query) {
    return _connection.request(ConnectionRequest(
        method: 'POST',
        path: '/_api/cursor',
        body: jsonEncode({'query': query})));
  }

  Collection collection(String name) {
    return Collection(name: name, connection: _connection);
  }
}
