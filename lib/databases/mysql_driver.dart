import 'package:mysql_client/mysql_client.dart';

import '../models/connection_model.dart';
import 'sql_driver.dart';

class MySqlDriver implements SqlDriver {
  late MySQLConnection _connection;

  @override
  Future<void> connect(ConnectionModel model) async {
    _connection = await MySQLConnection.createConnection(
      host: model.host,
      port: model.port,
      userName: model.username,
      password: model.password,
      databaseName: model.database,
    );

    await _connection.connect();
  }

  @override
  Future<List<Map<String, dynamic>>> select(
    String query, {
    Map<String, dynamic>? params,
  }) async {
    final List<Map<String, dynamic>> results = [];
    late IResultSet queryResults;

    try {
      final stmt = await _connection.prepare(query);

      if (params != null) {
        queryResults =
            await stmt.execute(params.entries.map((e) => e.value).toList());
      } else {
        queryResults = await stmt.execute([]);
      }

      for (var row in queryResults.rows) {
        results.add(row.assoc());
      }
    } catch (e) {
      print(e);
    }

    return results;
  }

  @override
  Future<bool> insert(String query, Map<String, dynamic>? params) async {
    late IResultSet queryResults;
    late int rowsAffected;

    try {
      final stmt = await _connection.prepare(query);

      if (params != null) {
        queryResults =
            await stmt.execute(params.entries.map((e) => e.value).toList());
      } else {
        queryResults = await stmt.execute([]);
      }

      rowsAffected = queryResults.affectedRows.toInt();
    } catch (e) {
      print(e);
    }

    if (rowsAffected == 0) {
      return false;
    }

    return true;
  }
}
