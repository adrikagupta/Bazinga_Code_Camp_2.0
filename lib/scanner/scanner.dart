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
  var data;
  var map = new Map<String, String>();

  Future<http.Response> scanUrl(String url) {
  map['url']  = url;
    return http.post(
      Uri.https('www.virustotal.com', 'api/v3/urls'),
      headers: <String, String>{
        'x-apikey': TOKEN,
      },
      body: map
    );
}

  Future<http.Response> getScanUrl(String id) {
    return http.get(
      Uri.https('www.virustotal.com', 'api/v3/analyses/$id'),
      headers: <String, String>{
        'x-apikey': TOKEN,
      },
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
              jsonData = await scanUrl('https://www.hackerrank.com/on-your-marks');
              jsonData = convert.jsonDecode(jsonData.body);
              data= jsonData["data"]["id"];
              jsonData = await getScanUrl(data);
              jsonData = convert.jsonDecode(jsonData.body);
              
              print(jsonData);

              // I/flutter (23427): {error: {message: Argument "url" is missing, code: BadRequestError}}

              },
          )
        ),
      ),
    );
  }
}