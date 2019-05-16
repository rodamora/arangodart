import 'dart:convert';
import 'package:http/http.dart' as http;

class ArangoDartResponse {
  int status;
  Map<String, dynamic> body;

  ArangoDartResponse({this.status, this.body});
}

class Http {
  Future<ArangoDartResponse> request(
      {String url,
      String method,
      String body,
      Map<String, String> headers}) async {
    var request;

    print(url);

    switch (method) {
      case 'POST':
        request = http.post(url, body: body, headers: headers);
        break;
      case 'PUT':
        request = http.put(url, body: body, headers: headers);
        break;
      case 'GET':
        request = http.get(url, headers: headers);
        break;
    }

    final response = await request;

    return ArangoDartResponse(
        status: response.statusCode, body: jsonDecode(response.body));
  }
}
