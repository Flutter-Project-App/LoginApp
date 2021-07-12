import 'package:flutter/material.dart';
import 'application.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(Application(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository()
  ));
}
