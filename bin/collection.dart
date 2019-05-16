import 'connection.dart';
import 'dart:convert';

class Collection {
  String name;
  Connection connection;

  Collection({this.connection, this.name});

  Future<List> all() async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/all',
        body: jsonEncode({'collection': name})));
    return data.body['result'] as List;
  }

  Future<List> first() async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/all',
        body: jsonEncode({'collection': name})));
    return data.body['result'] as List;
  }

  Future<dynamic> save(Map<String, dynamic> data) async {
    final response = await this.connection.request(ConnectionRequest(
        method: 'POST', path: '/_api/document/$name', body: jsonEncode(data)));
    return response.body;
  }

  Future<dynamic> replace(String handle, Map<String, dynamic> newValue) async {
    final response = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/document/$handle',
        body: jsonEncode(newValue)));
    return response.body;
  }

  Future<dynamic> update(String handle, Map<String, dynamic> newValue) async {
    final response = await this.connection.request(ConnectionRequest(
        method: 'PATCH',
        path: '/_api/document/$handle',
        body: jsonEncode(newValue)));
    return response.body;
  }

  Future<dynamic> remove(String handle) async {
    final response = await this.connection.request(
        ConnectionRequest(method: 'DELETE', path: '/_api/document/$handle'));
    return response.body;
  }

  Future<dynamic> import(List<Map<String, dynamic>> data) async {
    final body = data.map((line) => jsonEncode(line)).join(',');
    final response = await this.connection.request(ConnectionRequest(
        method: 'POST',
        path: '/_api/import',
        body: '[$body]',
        qs: '?collection=$name&type=list&details=true'));
    return response.body;
  }

  Future<Map<String, dynamic>> document(String handle) async {
    final data = await this.connection.request(
        ConnectionRequest(method: 'GET', path: '/_api/document/${handle}'));
    return data.body;
  }

  Future<String> byExample(Map<String, dynamic> example) async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/by-example',
        body: jsonEncode({'collection': name, 'example': example})));
    return data.body['result'];
  }

  Future<String> firstByExample(Map<String, dynamic> example) async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/first-example',
        body: jsonEncode({'collection': name, 'example': example})));
    return data.body['document'];
  }

  Future<dynamic> removeByExample(Map<String, dynamic> example) async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/remove-by-example',
        body: jsonEncode({'collection': name, 'example': example})));
    return data.body;
  }

  Future<dynamic> replaceByExample(
      Map<String, dynamic> example, Map<String, dynamic> newValue) async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/replace-by-example',
        body: jsonEncode(
            {'collection': name, 'example': example, 'newValue': newValue})));
    return data.body;
  }

  Future<dynamic> updateByExample(
      Map<String, dynamic> example, Map<String, dynamic> newValue) async {
    final data = await this.connection.request(ConnectionRequest(
        method: 'PUT',
        path: '/_api/simple/update-by-example',
        body: jsonEncode(
            {'collection': name, 'example': example, 'newValue': newValue})));
    return data.body;
  }
}
