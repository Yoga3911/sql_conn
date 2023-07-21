import 'package:daravel/handlers/auth_handler.dart';
import 'package:daravel/models/connection_model.dart';
import 'package:shelf/shelf.dart';

import 'databases/database_wrapper.dart';
import 'router/router.dart';
import 'utils/select_sql_driver.dart';

void main(List<String> arguments) async {
  final db = Database(selectSqlDriver(arguments));
  // ? POSTGRESQL
  // await db.connect(
  //   ConnectionModel(
  //     host: "localhost",
  //     database: "postgres",
  //     username: "postgres",
  //     password: "123456",
  //     port: 5555,
  //   ),
  // );
  // ? MYSQL
  await db.connect(
    ConnectionModel(
      host: "localhost",
      database: "coba",
      username: "root",
      password: "123456",
      port: 6666,
    ),
  );
  // ? Auth Handler
  final AuthHandler authHandler = AuthHandler(db);

  DaravelRouter router = DaravelRouter();

  router.get("", (request) async => Response.ok("Hello World"));

  // ? Auth Router
  final auth = router.group('auth');
  auth.post('login', authHandler.login);
  auth.post('register', authHandler.register);

  router.serve('localhost', 9999);
}
