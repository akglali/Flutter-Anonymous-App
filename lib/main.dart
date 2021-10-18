import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsiv_login_page_flutter/screens/home_page.dart';
import 'package:responsiv_login_page_flutter/screens/login_screen.dart';
import 'package:responsiv_login_page_flutter/utils/secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    _startApp();
    super.initState();
  }

  Future<void> _startApp() async {
    String? token = await SecureStorage().readKey('token');
    await Future.delayed(Duration(seconds: 1));
    if (token != null) {
      setState(() {
        isLoading = false;
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoading = false;
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoading ? Scaffold(
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.redAccent,
            size: 100,
            duration: Duration(seconds: 3),
          ),
        ),
      ) : isLoggedIn ?   HomePage(title:"Vibrany"):LoginScreen(title: "Vibrany"),
    );
  }
}
