import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsiv_login_page_flutter/http_services/login_signup_service.dart';
import 'package:responsiv_login_page_flutter/screens/components/button_component.dart';

import 'components/input_component.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.title});

  String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/icon.png'),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: const [
                      Colors.blue,
                      Colors.red,
                    ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputModel(
                          controller: username,
                          hint: 'Please Enter your username',
                          validationErr:
                              'Username must be more than 6 character',
                        ),
                        InputModel(
                          controller: password,
                          hint: "Enter your password",
                          isPass: true,
                          validationErr:
                              'Password must be more than 6 character',
                        ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonComponent(
                                formKey: _formKey,
                                buttonName: 'Signup',
                                function: () async {
                                  return await LoginSignupService(
                                          password: password.text,
                                          username: username.text)
                                      .signup();
                                },
                                err: 'User is already exist',
                                titleText: 'Too Late',
                                contentText: "Username is already taken",
                              ),
                              ButtonComponent(
                                formKey: _formKey,
                                buttonName: 'Login',
                                function: () async {
                                  return await LoginSignupService(
                                          password: password.text,
                                          username: username.text)
                                      .login();
                                },
                                err: 'Check your password',
                                contentText: 'Check your password and username',
                                titleText: 'Wrong Username Or Password',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
