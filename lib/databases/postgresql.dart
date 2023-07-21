import 'package:postgres/postgres.dart';

class PostgreSqlDriver {
  PostgreSqlDriver._();

  static init() async {
    var connection = PostgreSQLConnection(
      "localhost",
      5555,
      "postgres",
      username: "postgres",
      password: "123456",
    );
    await connection.open();
    final List<List<dynamic>> result =
        await connection.query("SELECT * FROM users;");
    for (var row in result) {
      print(row[0]);
      print(row[1]);
      print(row[2]);
    }
  }
}
