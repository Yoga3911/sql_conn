import 'package:shelf/shelf.dart';

import 'http_method_enum.dart';

class RouterEntry {
  final String path;
  final HttpMethod method;
  final Future<Response> Function(Request request) handler;

  const RouterEntry(
    this.path,
    this.method,
    this.handler,
  );
}
