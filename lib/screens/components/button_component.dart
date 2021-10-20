import 'package:flutter/material.dart';
import 'package:responsiv_login_page_flutter/screens/main_sreen.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    required GlobalKey<FormState> formKey,
    required this.buttonName,
    required this.function,
    required this.err,
    required this.titleText,
    required this.contentText,
    this.appBarText = "Vibrany",
  }) : _formKey = formKey;
  final String appBarText;
  final GlobalKey<FormState> _formKey;
  final String buttonName, err, contentText, titleText;
  final Future<dynamic> Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var buttonFunc = await function();
              if (buttonFunc == err) {
                AlertDialog alert = AlertDialog(
                  title: Text(titleText),
                  content: Text(
                    contentText,
                    style: TextStyle(color: Colors.red),
                  ),
                  actions: const [],
                );
                showDialog(context: context, builder: (context) => alert);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(title: appBarText)));
              }
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
            primary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          child: Text(buttonName)),
    );
  }
}
