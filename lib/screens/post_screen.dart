import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This is the Post Page"),
      ],
    );
  }
}