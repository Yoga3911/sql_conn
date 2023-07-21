import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import '../typedef/future_response.dart';
import 'http_method_enum.dart';
import 'router_entry.dart';

class DaravelRouter {
  DaravelRouter._internal();

  static final DaravelRouter _instance = DaravelRouter._internal();

  factory DaravelRouter() => _instance;

  final List<RouterEntry> _responses = [];

  void _add(RouterEntry entry) {
    _responses.add(entry);
  }

  void get(String path, DaravelResponse Function(Request request) handler) {
    _add(RouterEntry(path, HttpMethod.get, handler));
  }

  void post(String path, DaravelResponse Function(Request request) handler) {
    _add(RouterEntry(path, HttpMethod.post, handler));
  }

  void put(String path, DaravelResponse Function(Request request) handler) {
    _add(RouterEntry(path, HttpMethod.put, handler));
  }

  void patch(String path, DaravelResponse Function(Request request) handler) {
    _add(RouterEntry(path, HttpMethod.patch, handler));
  }

  void delete(String path, DaravelResponse Function(Request request) handler) {
    _add(RouterEntry(path, HttpMethod.delete, handler));
  }

  DaravelGroupRouter group(String prefix) {
    return DaravelGroupRouter(prefix);
  }

  DaravelResponse router(Request request) {
    for (var response in _responses) {
      if (request.url.path == response.path &&
          request.method == response.method.name) {
        return response.handler(request);
      }
    }

    return Future(() => Response.notFound("Not Found"));
  }

  Handler get handler =>
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  void serve(String host, int port, {String? scheme = 'http'}) async {
    final server = await io.serve(handler, host, port);
    server.autoCompress = true;

    print('Serving at $scheme://$host:$port');
  }
}

class DaravelGroupRouter {
  final String prefix;

  const DaravelGroupRouter(this.prefix);

  void get(String path, DaravelResponse Function(Request request) handler) {
    DaravelRouter().get('$prefix/$path', handler);
  }

  void post(String path, DaravelResponse Function(Request request) handler) {
    DaravelRouter().post('$prefix/$path', handler);
  }

  void put(String path, DaravelResponse Function(Request request) handler) {
    DaravelRouter().put('$prefix/$path', handler);
  }

  void patch(String path, DaravelResponse Function(Request request) handler) {
    DaravelRouter().patch('$prefix/$path', handler);
  }

  void delete(String path, DaravelResponse Function(Request request) handler) {
    DaravelRouter().delete('$prefix/$path', handler);
  }
}
