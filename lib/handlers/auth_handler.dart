import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../models/user_model.dart';
import '../typedef/future_response.dart';
import '../user_list.dart';

class AuthHandler {
  const AuthHandler._internal();

  static final AuthHandler _instance = const AuthHandler._internal();

  factory AuthHandler() => _instance;

  DaravelResponse register(Request request) async {
    final requestJson = await request.readAsString();
    final requestMap = jsonDecode(requestJson);

    final name = requestMap['name'];
    final password = requestMap['password'];
    users.add(
      UserModel(name: name, password: password),
    );

    final response = jsonEncode({
      "message": "Register success",
      "data": null,
    });

    return Response.ok(response);
  }

  DaravelResponse login(Request request) async {
    final requestJson = await request.readAsString();
    final requestMap = jsonDecode(requestJson);

    final name = requestMap['name'];
    final password = requestMap['password'];

    for (var user in users) {
      if (user.name == name) {
        if (user.password == password) {
          final response = jsonEncode({
            "message": "Login success",
            "data": {
              "name": user.name,
              "password": user.password,
            },
          });

          return Response.ok(response);
        }
      }
    }

    final response = jsonEncode({
      "message": "Password or username is wrong",
      "data": null,
    });

    return Response.unauthorized(response);
  }
}
