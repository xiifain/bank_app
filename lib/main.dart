import 'dart:convert';
import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<UserInfo>> fetchBankData(http.Client client) async {
  final response =
      await client.get('http://www.json-generator.com/api/json/get/ceSwDLJIOa?indent=2');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseBankData, response.body);
}

// A function that converts a response body into a List<Photo>.
List<UserInfo> parseBankData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserInfo>((json) => UserInfo.fromJson(json)).toList();
}
class UserInfo {
  final String id;
  final String balance;
  final String name;

  UserInfo({this.id, this.balance, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] as String,
      balance: json['balance'] as String,
      name: json['name'] as String,
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
        body: InkWell(
          child: Align(
            alignment: Alignment(0.0,-0.6),
            child: Container(
              width: 170,
              height: 170,
              child: Align(
                child: Text(
                  "BALANCE",
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
      ),
    );
  }
}
