import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/utils/custom_theme.dart';
import 'package:manager_app/core/localization/change_locale.dart';
import 'package:manager_app/core/localization/localization.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:manager_app/features/auth/presentation/views/screens/login.dart';
import 'package:manager_app/firebase_options.dart';
import 'package:manager_app/core/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
    ),
  ], child: const ManagerApp()));
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
