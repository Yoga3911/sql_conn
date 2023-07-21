import '../models/connection_model.dart';

abstract class SqlDriver {
  Future<void> connect(ConnectionModel model);

  Future<List<Map<String, dynamic>>> select(
    String query, {
    Map<String, dynamic>? params,
  });

  Future<bool> insert(String query, Map<String, dynamic>? params);
}
