import '../models/connection_model.dart';
import 'sql_driver.dart';

class Database {
  final SqlDriver sql;
  const Database(this.sql);

  Future<void> connect(ConnectionModel model) async {
    return await sql.connect(model);
  }

  Future<List<Map<String, dynamic>>> select(
    String query, {
    Map<String, dynamic>? params,
  }) async {
    return await sql.select(query, params: params);
  }

  Future<bool> insert(
    String query, {
    Map<String, dynamic>? params,
  }) async {
    return await sql.insert(query, params);
  }
}
