class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginSuccess extends AuthStates {}

class LoginFailure extends AuthStates {
  late String message;

  LoginFailure({required this.message});
}

class LoginLoading extends AuthStates {}

class RegisterSuccess extends AuthStates {}

class RegisterFailure extends AuthStates {
  late String message;

  RegisterFailure({required this.message});
}

class RegisterLoading extends AuthStates {}

class VerificationEmailSuccess extends AuthStates {}

class VerificationEmailFailure extends AuthStates {
  late String message;

  VerificationEmailFailure({required this.message});
}

class LogoutSuccess extends AuthStates {}

class VerificationEmailLoading extends AuthStates {}

class VerificationEmailDone extends AuthStates {}
