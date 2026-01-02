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

Widget buildpostItem(context) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text("Abdulhamead"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "10:00 pm 27/7/2025",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 18,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 5,
            ),
            child: SizedBox(
              width: double.infinity,
              //زيها زي column ,row ,بس انها الها مميزات اكثر
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text('#software_development',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '252',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '252 comment',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      size: 20,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'like',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
