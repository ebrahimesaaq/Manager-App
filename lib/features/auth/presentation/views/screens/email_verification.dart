import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manager_app/core/constants/app_colors.dart';
import 'package:manager_app/core/constants/routes.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is VerificationEmailLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors.lightRed,
              ),
            ),
          );
        } else if (state is VerificationEmailFailure) {
          Get.snackbar('error'.tr,
              '${'failed-send-verification-email'.tr}: ${state.message}',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (state is VerificationEmailDone) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'isEmailVerified': true});
          if (Get.isDialogOpen!) Get.back();

          Get.offAllNamed(AppRoutes.home);
        }
      }, builder: (context, state) {
        if (state is VerificationEmailSuccess) {
          return Center(
            child: Text('verification-sent'.tr),
          );
        } else if (state is VerificationEmailFailure) {
          return Center(
            child: Text(
                '${'failed-send-verification-email'.tr}: ${state.message}'),
          );
        } else {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().verificationEmail();
                // Trigger email verification
              },
              child: Text('verification-email'.tr),
            ),
          );
        }
      }),
    );
  }
}
