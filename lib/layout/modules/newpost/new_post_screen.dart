import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:defaultAppBar(context, "Add Post", []),
    );
  }
}
