import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/modules/login/cubit_login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
      //  CacheHelper.saveData(key: 'uId', value: value.user!.uid);
        emit(SocialLoginSuccesState(value.user!.uid));
        print(CacheHelper.getData(key: 'uId'));

      },
    ).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

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
