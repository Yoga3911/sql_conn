import 'package:args/args.dart';

import '../databases/mysql_driver.dart';
import '../databases/postgresql_driver.dart';
import '../databases/sql_driver.dart';

SqlDriver selectSqlDriver(List<String> arguments) {
  final ArgParser argParser = ArgParser();
  argParser.addOption('driver');

  ArgResults argResults = argParser.parse(arguments);

  String? driver = argResults['driver'] ?? "";
  late SqlDriver sqlDriver;

  switch (driver) {
    case "mysql":
      sqlDriver = MySqlDriver();
      break;
    case "psql":
      sqlDriver = PostgreSqlDriver();
      break;
    default:
      sqlDriver = MySqlDriver();
  }

  print("Driver: $driver");

  return sqlDriver;
}
