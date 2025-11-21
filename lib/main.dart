import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/custom_theme.dart';
import 'package:manager_app/core/localization/change_locale.dart';
import 'package:manager_app/core/localization/localization.dart';
import 'package:manager_app/features/auth/login.dart';
import 'package:manager_app/firebase_options.dart';
import 'package:manager_app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ManagerApp());
}

class ManagerApp extends StatelessWidget {
  const ManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeLocal changeLocal = Get.put(ChangeLocal());
    return GetMaterialApp(
      locale: changeLocal.language,
      translations: Languages(),
      debugShowCheckedModeBanner: false,
      home: Login(),
      themeMode: ThemeMode.dark,
      darkTheme: customDark,
      routes: myRoutes,
    );
  }
}
