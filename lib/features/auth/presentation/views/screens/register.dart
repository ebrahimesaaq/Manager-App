import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/core/shared/custom_dialog.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:manager_app/features/auth/presentation/views/widgets/register_ui.dart';

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
              Get.toNamed(AppRoutes.verification);
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading   ) {
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
