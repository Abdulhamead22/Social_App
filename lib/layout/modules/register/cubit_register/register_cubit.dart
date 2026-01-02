
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/modules/register/cubit_register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  //SocialLoginModel? loginModel;

  // void userRegister({required String name,required String email, required String password,required String phone}) {
  //   emit(SocialRegisterLodingState()); 
  //   DioHelperSocial.postData(
  //     url: 'register',
  //     data: {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'phone': phone,
  //     },
  //   ).then(
  //     (value) {
  //       // التحقق من حالة الاستجابة (status code)
  //       if (value?.statusCode == 200) {
  //         print(value?.data); 
  //         loginModel = SocialLoginModel.fromJson(value?.data);

  //         // التحقق من استجابة الـ API (إذا كانت حالة النجاح true)
  //         if (loginModel != null && loginModel!.status) {
  //           CacheHelper.saveData(key: "token", value: loginModel?.data?.token); // تخزين الـ token
  //           emit(SocialRegisterSuccesState(loginModel!)); 
  //         } else {
  //           emit(SocialRegisterErrorState()); // إذا كان الـ status في الـ loginModel غير ناجح
  //           toast(loginModel?.message ?? "Login failed", Colors.red); 
  //         }
  //       } else {
  //         emit(SocialRegisterErrorState());
  //         toast("Something went wrong. Please try again later.", Colors.red);
  //       }
  //     },
  //   ).catchError((error) {
  //     print(error.toString());
  //     emit(SocialRegisterErrorState());
  //     toast("Error: ${error.toString()}", Colors.red);
  //   });
  // }

  Widget suffixIcon = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(SocialRegisterChangeIconSuffixState()); 
  }
}
