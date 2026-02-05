import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiLogger {
  ApiLogger._();

  static void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) {
    debugPrint('┌────────────────────────────────────────────');
    debugPrint('│ 🌐 API REQUEST');
    debugPrint('├────────────────────────────────────────────');
    debugPrint('│ Method : $method');
    debugPrint('│ URL    : $url');

    if (headers != null && headers.isNotEmpty) {
      debugPrint('│ Headers:');
      headers.forEach((key, value) {
        debugPrint('│   $key: $value');
      });
    }

    if (body != null) {
      debugPrint('│ Body   : $body');
    }

    debugPrint('├────────────────────────────────────────────');
  }

  static void logResponse(http.Response response) {
    debugPrint('│ 📥 API RESPONSE');
    debugPrint('├────────────────────────────────────────────');
    debugPrint('│ Status : ${response.statusCode}');
    debugPrint('│ Body   : ${response.body}');
    debugPrint('└────────────────────────────────────────────');
  }


  static void logError(
    dynamic error, {
    String? method,
    String? url,
    StackTrace? stackTrace,
  }) {
    debugPrint('┌────────────────────────────────────────────');
    debugPrint('│ ❌ API ERROR');

    if (method != null) debugPrint('│ Method : $method');
    if (url != null) debugPrint('│ URL    : $url');

    debugPrint('│ Error  : $error');

    if (stackTrace != null) {
      debugPrint('│ StackTrace: $stackTrace');
    }

    debugPrint('└────────────────────────────────────────────');
  }

  static void logComplete({
    required String method,
    required String url,
    required http.Response response,
    Map<String, String>? headers,
    dynamic requestBody,
  }) {
    logRequest(method: method, url: url, headers: headers, body: requestBody);
    logResponse(response);
  }
}
