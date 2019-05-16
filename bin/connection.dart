import 'http.dart';

class RequestBody {
  String collection;
  String query;
}

class ConnectionRequest {
  String method;
  String path;
  String body;
  String qs;

  ConnectionRequest({this.method, this.path, this.body, this.qs});
}

class Connection {
  final Http http = Http();
  String _databaseName;
  final Map<String, String> _headers = {};

  Connect(Map<String, dynamic> config) {}

  String _baseUrl() {
    return 'http://localhost:8529/_db/$_databaseName';
  }

  setDatabaseName(String name) {
    _databaseName = name;
  }

  setHeader(String key, String value) {
    _headers[key] = value;
  }

  Future<ArangoDartResponse> request(ConnectionRequest request) async {
    String url = '${_baseUrl()}${request.path}';

    if (request.qs != null) {
      url += request.qs;
    }

    return http.request(
        url: url,
        method: request.method,
        body: request.body,
        headers: _headers);
  }
}
