import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  Future addUser({
    required String emailController,
    required String passwordController,
    required String username,
    required String mobile,
  }) async {
    await authentication(
        emit, emailController, passwordController, username, mobile);
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
  FirebaseFirestore.instance.collection('users').doc(uid).set({
    'username': username,
    'email': email,
    'mobile': mobile,
    'uid': uid,
  });
}
