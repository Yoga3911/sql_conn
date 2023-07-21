class ConnectionModel {
  final String host;
  final String database;
  final String username;
  final String password;
  final int port;

  const ConnectionModel({
    required this.host,
    required this.database,
    required this.username,
    required this.password,
    required this.port,
  });
}
