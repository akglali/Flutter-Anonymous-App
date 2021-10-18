import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:responsiv_login_page_flutter/utils/secure_storage.dart';

class LoginSignupService {
  String username, password;
  String domain='http://10.44.65.119:8000/user/';

  LoginSignupService({required this.username, required this.password});

  Future<String> signup() async {
    var url = Uri.parse('${domain}signup');
    var response = await http.post(url,body: json.encode({"username":username,"password":password}));
    var body=jsonDecode(response.body);
    if (response.statusCode != 200) {
      return (body["Error"]);
    }
    await SecureStorage().writeKey("token",body);
    return body;
  }

  Future<String> login() async {
    var url = Uri.parse('${domain}login');
    var response = await http.post(url,body: json.encode({"username":username,"password":password}));
    var body=jsonDecode(response.body);
    if (response.statusCode != 200) {
      return body["Error"];
    }
    var token =await SecureStorage().readKey("token");
    if(token!= null){
      await SecureStorage().deleteAll();
    }
    await SecureStorage().writeKey( "token",body);
    return body;
  }
}
