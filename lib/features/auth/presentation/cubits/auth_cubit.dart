import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  Timer? timer;
  Future addUser({
    required String emailController,
    required String passwordController,
    required String username,
    required String mobile,
  }) async {
    await authentication(
        emit, emailController, passwordController, username, mobile);
  }

  Future verificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    timer = await sendAVerificationEmail(
      user: user,
      emit: emit,
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

Future authentication(
  void Function(AuthStates) emit,
  emailController,
  passwordController,
  username,
  mobile,
) async {
  emit(RegisterLoading());
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController,
      password: passwordController,
    );
    await addUserData(credential.user!.uid, username, emailController, mobile);
    emit(RegisterSuccess());
  } on FirebaseAuthException catch (e) {
    emit(RegisterFailure(message: e.code));
  } catch (e) {
    emit(RegisterFailure(message: e.toString()));
  }
}

Future addUserData(
    String uid, String username, String email, String mobile) async {
  if (uid.isEmpty) {
    throw Exception("UID is empty");
  }
  await FirebaseFirestore.instance.collection('users').doc(uid).set(
    {
      'username': username,
      'email': email,
      'mobile': mobile,
      'uid': uid,
    },
  );
}

Future<Timer> sendAVerificationEmail({
  required User? user,
  required void Function(AuthStates) emit,
}) async {
  emit(VerificationEmailLoading());
  await user!.sendEmailVerification();
  emit(VerificationEmailSuccess());
  return Timer.periodic(
    Duration(seconds: 3),
    (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      User? refreshUser = FirebaseAuth.instance.currentUser;
      if (refreshUser!.emailVerified) {
        timer.cancel();
        emit(VerificationEmailDone());
      }
    },
  );
}
