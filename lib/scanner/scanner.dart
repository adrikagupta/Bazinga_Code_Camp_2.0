import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../token/token.dart';
import 'dart:async';
import 'dart:convert' as convert;

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String url1;
  var jsonData;
  List data;
  Future<http.Response> scanUrl(String url) {
  return http.post(
    Uri.https('www.virustotal.com', 'api/v3/urls'),
    headers: <String, String>{
      'x-apikey': TOKEN,
    },
    body: convert.jsonEncode(<String, String>{
      'url': url,
    }),
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: TextButton(
            child: Text('Search'),
            onPressed: () async {
              print('Hi');
              jsonData = await scanUrl('https://flutter.dev/docs/cookbook/networking/send-data');
              jsonData = convert.jsonDecode(jsonData.body);
              data= jsonData["attributes"];
              print(data);
              },
          )
        ),
      ),
    );
  }
}