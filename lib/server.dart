import 'package:daravel/handlers/auth_handler.dart';
import 'package:shelf/shelf.dart';

import 'router/router.dart';

void main() async {
  // ? Auth Handler
  final AuthHandler authHandler = AuthHandler();

  DaravelRouter router = DaravelRouter();

  router.get("", (request) async => Response.ok("Hello World"));

  // ? Auth Router
  final auth = router.group('auth');
  auth.post('login', authHandler.login);
  auth.post('register', authHandler.register);

  router.serve('localhost', 9999);
}
