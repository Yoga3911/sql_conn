import 'package:postgres/postgres.dart';

import '../models/connection_model.dart';
import 'sql_driver.dart';

class PostgreSqlDriver implements SqlDriver {
  late PostgreSQLConnection _connection;

  @override
  Future<void> connect(ConnectionModel model) async {
    _connection = PostgreSQLConnection(
      model.host,
      model.port,
      model.database,
      username: model.username,
      password: model.password,
    );

    await _connection.open();
  }

  @override
  Future<List<Map<String, dynamic>>> select(
    String query, {
    Map<String, dynamic>? params,
  }) async {
    final List<Map<String, dynamic>> results = [];
    late PostgreSQLResult queryResults;

    try {
      if (params != null) {
        queryResults = await _connection.query(
            _replaceQuery(query, params.keys.toList()),
            substitutionValues: params);
      } else {
        queryResults = await _connection.query(query);
      }

      for (var row in queryResults) {
        results.add(row.toColumnMap());
      }
    } catch (e) {
      print(e);
    }

    return results;
  }

  @override
  Future<bool> insert(String query, Map<String, dynamic>? params) async {
    late PostgreSQLResult queryResults;
    late int rowsAffected;

    try {
      if (params != null) {
        queryResults = await _connection.query(
            _replaceQuery(query, params.keys.toList()),
            substitutionValues: params);
      } else {
        queryResults = await _connection.query(query);
      }

      rowsAffected = queryResults.affectedRowCount;
    } catch (e) {
      print(e);
    }

    if (rowsAffected == 0) {
      return false;
    }

    return true;
  }

  String _replaceQuery(String originalQuery, List<dynamic> columnPlaceholders) {
    int placeholderIndex = 0;

    originalQuery = originalQuery.replaceAllMapped('?', (match) {
      if (placeholderIndex < columnPlaceholders.length) {
        String placeholder = columnPlaceholders[placeholderIndex];
        placeholderIndex++;
        return "@$placeholder";
      }
      return match.group(0) ?? "?";
    });

    return originalQuery;
  }
}
