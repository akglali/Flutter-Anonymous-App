import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  String domain = 'http://192.168.43.56:8000/post/';
  var map = <String, Color>{
    "bg-blue-100": Colors.blue.shade100,
    "bg-red-100": Colors.red.shade100,
    "bg-purple-100": Colors.purple.shade100,
    "bg-gray-100": Colors.grey.shade100,
    "bg-green-100": Colors.green.shade100,
    "bg-yellow-100": Colors.yellow.shade100,
    "bg-indigo-100": Colors.indigo.shade100,
    "bg-pink-100": Colors.pink.shade100,
    "bg-blue-300": Colors.blue.shade300,
    "bg-red-300": Colors.red.shade300,
    "bg-purple-300": Colors.purple.shade300,
    "bg-gray-300": Colors.grey.shade300,
    "bg-green-300": Colors.green.shade300,
    "bg-yellow-300": Colors.yellow.shade300,
    "bg-indigo-300": Colors.indigo.shade300,
    "bg-pink-300": Colors.pink.shade300
  };

  Future<List> getAllPost(int pageNumber) async {
    var url = Uri.parse('${domain}getallpost/${pageNumber}');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return [body];
    }
    for (var prop in body) {
      prop["Color"] = map[prop["Color"]];
    }
    return body;
  }
}
