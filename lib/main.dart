import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import './services/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  //

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Map mapResponse;
  List listResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("News Articles"),
        ),
        body: Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    Container(
                        color: Colors.amber,
                        child: Text(listResponse[index]['name'])),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Text(
                        listResponse[index]['url'],
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        if (canLaunch(listResponse[index]['url']) != null) {
                          launch(listResponse[index]['url']);
                        }
                      },
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              );
            },
            itemCount: listResponse == null ? 0 : listResponse.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: getArticle,
        ),
      ),
    );
  }

  getArticle() async {
    var url = Uri.parse("https://hubblesite.org/api/v3/news");

    var response = await http.get(url);
    //print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        //mapResponse = json.decode(response.body);
        listResponse = json.decode(response.body);
      });
    }
    // print(mapResponse);
    print(listResponse);
  }
}
