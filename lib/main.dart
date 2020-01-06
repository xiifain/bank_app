import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<AccountInfo>> fetchAccountData(http.Client client) async {
  final response = 
    await client.get('http://10.0.2.2:8000/languages/');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseAccountData, response.body);
}

// A function that converts a response body into a List<Photo>.
List<AccountInfo> parseAccountData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AccountInfo>((json) => AccountInfo.fromJson(json)).toList();
}

class AccountInfo {
  final String name;
  final int balance;

  AccountInfo({this.name, this.balance});

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      name: json['name'] as String,
      balance: json['balance'] as int,
    );
  }
}

void main() => runApp(BankApp());

class BankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: FutureBuilder(
            future: fetchAccountData(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? Circle(accountInfo: snapshot.data,)
                  : Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class Circle extends StatelessWidget {

  final List<AccountInfo> accountInfo;

  Circle({Key key, this.accountInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Align(
          alignment: Alignment(0.0, -0.6),
          child: Container(
            width: 170,
            height: 170,
            child: Align(
              child: Text(
                accountInfo[1].balance.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffdddddd),
                  fontSize: 25.0,
                ),
              ),
              alignment: Alignment.center,
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xFFadadad),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 15.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
