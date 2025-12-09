import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/core/shared/app_buttons.dart';
import 'package:manager_app/core/shared/app_text_form_field.dart';
import 'package:manager_app/core/shared/custom_dialog.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterUI extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController emailController;
  final TextEditingController mobile;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final GlobalKey<FormState> formKey;
  const RegisterUI(
      {super.key,
      required this.username,
      required this.emailController,
      required this.mobile,
      required this.passwordController,
      required this.passwordConfirmController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
            ),
            Text(
              'registerBtn'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppTextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "usernameErr".tr;
                }
                return null;
              },
              controller: username,
              title: 'username'.tr,
              label: 'username'.tr,
            ),
            AppTextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "emailErr".tr;
                }
                return null;
              },
              controller: emailController,
              title: 'email'.tr,
              label: 'email'.tr,
            ),
            AppTextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "mobileErr".tr;
                }
                return null;
              },
              controller: mobile,
              title: 'mobile'.tr,
              label: 'mobile'.tr,
            ),
            AppTextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "passwordErr".tr;
                }
                return null;
              },
              controller: passwordController,
              label: 'password'.tr,
              title: 'password'.tr,
            ),
            AppTextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "confirmPassErr".tr;
                }
                return null;
              },
              controller: passwordConfirmController,
              label: 'passwordConfirm'.tr,
              title: 'passwordConfirm'.tr,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: AppButtons(
                onPress: () {
                  if (formKey.currentState!.validate() &&
                      (passwordController.text ==
                          passwordConfirmController.text)) {
                    if (passwordController.text !=
                        passwordConfirmController.text) {
                      Get.dialog(
                        CustomDialog(
                          
                          title: 'error'.tr,
                          content: 'passwords-not-match'.tr,
                        ),
                      );
                      return;
                    }
                    context.read<AuthCubit>().addUser(
                          username: username.text,
                          mobile: mobile.text,
                          emailController: emailController.text,
                          passwordController: passwordController.text,
                        );
                  }
                },
                btnName: 'registerBtn'.tr,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('haveAccount'.tr),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.loginPage);
                    },
                    child: Text(
                      'login'.tr,
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
        ),
      ),
    );
  }
}
