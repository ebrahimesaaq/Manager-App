import 'package:flutter/material.dart';
import 'package:manager_app/core/routes.dart';
import 'package:manager_app/features/auth/login.dart';
import 'package:manager_app/features/auth/register.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  AppRoutes.loginPage: (context) => const Login(),
  AppRoutes.register: (context) => const Register(),
};
