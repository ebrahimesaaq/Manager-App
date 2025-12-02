import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/core/shared/app_buttons.dart';
import 'package:manager_app/core/shared/app_text_form_field.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: BlocBuilder<AuthCubit, dynamic>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoginFailure) {
                  return Center(
                    child: Text('Error'),
                  );
                } else if (state is LoginSuccess) {
                  return LoginUi(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                  );
                }
                return LoginUi(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoginUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  const LoginUi(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
        ),
        Text(
          'welcome'.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('loginWord'.tr),
        AppTextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'emailErr'.tr;
            }
            return null;
          },
          controller: emailController,
          title: 'email'.tr,
          label: 'Email'.tr,
        ),
        AppTextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'passErr'.tr;
            }
            return null;
          },
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.white,
            ),
          ),
          controller: passwordController,
          label: 'password'.tr,
          title: 'password'.tr,
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'forgetPassword'.tr,
              style: TextStyle(color: AppColors.blueButtons),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: AppButtons(
            onPress: () {
              
              if (formKey.currentState!.validate()) {
                
              }
            },
            btnName: 'login'.tr,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('dontHaveAccount'.tr),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.register);
                },
                child: Text(
                  'register'.tr,
                  style: TextStyle(
                      color: AppColors.blueButtons,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
