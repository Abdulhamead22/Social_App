import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/icon_broken.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDrevider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      width: double.infinity,
      height: 2,
      color: Colors.black,
    ),
  );
}

TextFormField textField({
  required TextEditingController controller,
  required String input,
  TextInputType keytype = TextInputType.emailAddress,
  required Icon icon,
  Widget? suffixIcons,
  required FormFieldValidator<String> validate,
  GestureTapCallback? ontap,
  var onchange,
  FocusNode? focusNode,
  ValueChanged<String>? onsubmit,
  bool isPassword = false,
}) {
  return TextFormField(
    style: const TextStyle(color: Colors.black),
    focusNode: focusNode,
    onEditingComplete: () {
      focusNode?.unfocus();
      scheduleMicrotask(
          focusNode!.requestFocus); // need to `import 'dart:async';`
    },
    decoration: InputDecoration(
      labelText: input,
      hintText: "Enter $input",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon: icon,
      suffixIcon: suffixIcons,
    ),
    obscureText: isPassword, //للنص مخفي ولا لا
    keyboardType: keytype,
    onFieldSubmitted: onsubmit,
    onTap: ontap,
    onChanged: onchange,
    controller: controller,
    validator: validate,
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color backgraund = Colors.blue,
  bool isuper = true,
  double radies = 3.0,
  required VoidCallback? function,
  required String text,
  double fontsize = 30,
}) {
  return Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radies),
      color: backgraund,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontsize,
          color: Colors.white,
        ),
      ),
    ),
  );
}

PreferredSizeWidget? defaultAppBar(
  BuildContext context,
  String title,
  List<Widget> actions,
) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(IconBroken.Arrow___Left_2),
    ),
    titleSpacing: 5.0,
    title: Text(
      title,
    ),
    actions: actions,
  );
}

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) {
  return TextButton(
    onPressed: function,
    child: Text(text),
  );
}

Future<dynamic> navigatFinish(context, builder) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) {
        return builder;
      },
    ),
    (route) {
      return false;
    },
  );
}

Future<dynamic> navigatTo(context, builder) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return builder;
      },
    ),
  );
}

Future<bool?> toast(String text, Color color) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// void signOut(context) {
//   CacheHelper.clearData(key: 'token').then(
//     (value) {
//       if (value) {
//         navigatTo(context, LoginScreen());
//       }
//     },
//   );
// }

Container emailVerified() {
  return Container(
    height: 50,
    color: Colors.amber.withOpacity(0.65),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Icon(Icons.info_outline),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text("Please verify email"),
          ),
          const SizedBox(
            width: 20,
          ),
          defaultTextButton(
            function: () {
              FirebaseAuth.instance.currentUser?.sendEmailVerification().then(
                (value) {
                  toast("check your email", Colors.green);
                },
              ).catchError((error) {});
            },
            text: "Send",
          ),
        ],
      ),
    ),
  );
}
