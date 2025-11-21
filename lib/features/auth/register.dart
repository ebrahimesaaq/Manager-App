import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/routes.dart';
import 'package:manager_app/core/shared/app_buttons.dart';
import 'package:manager_app/core/shared/app_text_form_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    usernameController.dispose();
    passwordConfirmController.dispose();
    passwordController.dispose();
    emailController.dispose();
    mobileController.dispose();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
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
                  controller: usernameController,
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
                  controller: mobileController,
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
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: AppButtons(
                    onPress: () {
                      if (formKey.currentState!.validate()) {}
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
        ),
      ),
    );
  }
}
