import 'package:flutter/material.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/features/auth/presentation/views/screens/login.dart';
import 'package:manager_app/features/auth/presentation/views/screens/register.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  AppRoutes.loginPage: (context) => const Login(),
  AppRoutes.register: (context) => const Register(),
};
