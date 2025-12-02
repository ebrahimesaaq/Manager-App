import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/core/shared/app_buttons.dart';
import 'package:manager_app/core/shared/app_text_form_field.dart';
import 'package:manager_app/core/shared/custom_dialog.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';

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
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              String title;
              String content;
              if (state.message == 'weak-password') {
                title = 'weak-pass'.tr;
                content = 'weak-pass-err'.tr;
              } else if (state.message == 'email-already-in-use') {
                title = 'email-already-in-use'.tr;
                content = 'email-already-in-use-err'.tr;
              } else {
                title = 'unknown'.tr;
                content = state.message.toUpperCase();
              }

              showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  onPressedCancel: () {},
                  title: title,
                  content: content,
                  okBtn: 'ok'.tr,
                  cancelBtn: 'cancel'.tr,
                ),
              );
            } else if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('successAddAccount'.tr),
                  backgroundColor: AppColors.lightGrey,
                ),
              );
              Get.offAllNamed(AppRoutes.loginPage);
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading ||
                state is RegisterFailure ||
                state is RegisterSuccess) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return RegisterUI(
              username: usernameController,
              emailController: emailController,
              mobile: mobileController,
              passwordController: passwordController,
              passwordConfirmController: passwordConfirmController,
              formKey: formKey,
            );
          },
        ),
      ),
    );
  }
}

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
                  if (formKey.currentState!.validate()) {
                    // final authCubit = AuthCubit();
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
