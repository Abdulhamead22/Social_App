import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/modules/login/cubit_login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  // دالة تسجيل الدخول
  // void userLogin({required String email, required String password}) {
  //   emit(SocialLoginLodingState()); // بدء التحميل
  //   DioHelperSocial.postData(
  //     url: 'login',
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then(
  //     (value) {
  //       // التحقق من حالة الاستجابة (status code)
  //       if (value?.statusCode == 200) {
  //         print(value?.data); // طباعة البيانات المستلمة من الـ API
  //         loginModel = SocialLoginModel.fromJson(value?.data);

  //         // التحقق من استجابة الـ API (إذا كانت حالة النجاح true)
  //         if (loginModel != null && loginModel!.status) {
  //           CacheHelper.saveData(key: "token", value: loginModel?.data?.token); // تخزين الـ token
  //           emit(SocialLoginSuccesState(loginModel!)); // تغيير الحالة إلى نجاح
  //         } else {
  //           emit(SocialLoginErrorState()); // إذا كان الـ status في الـ loginModel غير ناجح
  //           toast(loginModel?.message ?? "Login failed", Colors.red); // إظهار رسالة الخطأ
  //         }
  //       } else {
  //         // إذا كانت حالة الاستجابة غير 200
  //         emit(SocialLoginErrorState());
  //         toast("Something went wrong. Please try again later.", Colors.red);
  //       }
  //     },
  //   ).catchError((error) {
  //     // التعامل مع الأخطاء في حال حدوث خطأ في الاتصال
  //     print(error.toString());
  //     emit(SocialLoginErrorState());
  //     toast("Error: ${error.toString()}", Colors.red);
  //   });
  // }

  // التعامل مع الأيقونة الخاصة بكلمة المرور
  Widget suffixIcon = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(SocialChangeIconSuffixState()); // تغيير الحالة للأيقونة
  }
}
