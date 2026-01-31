import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/modules/login/cubit_login/login_cubit.dart';
import 'package:flutter_application_1/layout/modules/login/cubit_login/login_state.dart';
import 'package:flutter_application_1/layout/modules/register/register_screen.dart';
import 'package:flutter_application_1/layout/social_layout.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    final FocusNode emailfocusNode = FocusNode();
    final FocusNode passwordfocusNode = FocusNode();
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            toast(state.error, Colors.red);
          }
          if (state is SocialLoginSuccesState) {
            //عشان اقدر اصل لل uId ,, لازم ابعت model مع state
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then(
              (value) {
                // ignore: use_build_context_synchronously
                navigatFinish(context, const SocialLayout());
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        textField(
                          controller: emailController,
                          input: "Email",
                          icon: const Icon(Icons.email_outlined),
                          validate: (value) {
                            if (value == '') {
                              return "must have email";
                            }
                            return null;
                          },
                          focusNode: emailfocusNode,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        textField(
                          controller: passwordController,
                          input: "Password",
                          icon: const Icon(Icons.lock_outline),
                          validate: (value) {
                            if (value == '') {
                              return "password is short";
                            }
                            return null;
                          },
                          onsubmit: (value) {
                            //عملتها هنا كمان عشان لما اضغط ينتقل مباشرة للي بعدها
                            if (formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          keytype: TextInputType.visiblePassword,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixIcons: IconButton(
                            onPressed:
                                SocialLoginCubit.get(context).changeSuffixIcon,
                            icon: SocialLoginCubit.get(context).suffixIcon,
                          ),
                          focusNode: passwordfocusNode,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLodingState,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "Login",
                              isuper: true,
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account? "),
                            defaultTextButton(
                              function: () {
                                navigatTo(context, const RegisterScreen());
                              },
                              text: "Register",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
