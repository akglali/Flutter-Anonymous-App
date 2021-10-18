import 'dart:convert';

import 'package:http/http.dart' as http;

class HomePageService{
  String domain='http://10.44.65.119:8000/post/';


  Future<String> getAllPost() async{
    var url=Uri.parse('${domain}getallpost');
    var response=await http.get(url);
    var body=jsonDecode(response.body);
    if (response.statusCode != 200) {
      return (body["Error"]);
    }
    print(body);

    return"";
  }
 }