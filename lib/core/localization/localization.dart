import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'welcome': 'مرحبا بعودتك من جديد!',
          'email': 'البريد الالكتروني',
          'password': 'الرقم السري',
          'login': 'تسحيل الدخول',
          'loginWord': 'سجل الدخول للمتابعة الى لوحة التحكم الخاصة بك',
          'forgetPassword': 'هل نسيت كلمة المرور؟',
          'dontHaveAccount': 'ليس لديك حساب؟',
          'haveAccount': 'بالفعل لديك حساب؟',
          'register': 'تسحيل الان',
          'registerBtn': 'سجل',
          'passwordConfirm': 'اعد ادخال كلمة المرور',
          'mobile': 'رقم الهاتف',
          'username': 'اسم المستخدم',
          'emailErr': 'برجاء ادخال البريد الالكتروني!',
          'passErr': 'برجاء ادخال كلمة المرور!',
        },
        'en': {
          'welcome': 'Welcome Back!',
          'email': 'Email',
          'password': 'Password',
          'login': 'Login',
          'loginWord': 'Login to continue manage your dashboard',
          'forgetPassword': 'Forget password?',
          'dontHaveAccount': 'Dont have an account?',
          'haveAccount': 'Already have an account?',
          'register': 'Register now',
          'registerBtn': 'Register',
          'passwordConfirm': 'Confirm your password',
          'mobile': 'Mobile',
          'username': 'Username',
          'emailErr': 'Please enter your email!',
          'passErr': 'Please enter your password!',
        },
      };
}
