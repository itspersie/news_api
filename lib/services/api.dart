import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Api {
  void getArticle() async {
    // var client = http.Client();
    var url = Uri.parse("https://hubblesite.org/api/v3/news");

    var response = await http.get(url);
    print(response.body);
  }
}
