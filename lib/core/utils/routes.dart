import 'package:flutter/material.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/features/auth/presentation/views/screens/email_verification.dart';
import 'package:manager_app/features/auth/presentation/views/screens/login.dart';
import 'package:manager_app/features/auth/presentation/views/screens/register.dart';
import 'package:manager_app/features/home/presentation/views/screens/home_page.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  AppRoutes.loginPage: (context) => const Login(),
  AppRoutes.register: (context) => const Register(),
  AppRoutes.verification: (context) => const EmailVerification(),
  AppRoutes.home: (context) => const HomePage(),
};
