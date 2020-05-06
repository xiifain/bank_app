import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


Future<AccountInfo> fetchAccountData(http.Client client) async {
  // final response = await client.get('http://10.0.2.2:8000/languages/');
  final response = await client.get('https://flutter-bank-app.firebaseio.com/users/.json');

  print(response.body);


  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseAccountData, response.body);
}

Future<void> addAccountBalance(http.Client client,int balance) async
{
  final addResponse = await client.get('https://flutter-bank-app.firebaseio.com/users/.json');

  final parsedBalance = jsonDecode(addResponse.body);

  AccountInfo accInfo = AccountInfo.fromJson(parsedBalance);

  // final addedBalance = accInfo.balance + balance;
  final addedBalance = accInfo.balance + balance;

  const url = 'https://flutter-bank-app.firebaseio.com/users/.json';

  client.patch(url,body: json.encode({
    'name' : accInfo.name,  
    'balance' : addedBalance
  }));
}

// A function that converts a response body into a List<Photo>.
AccountInfo parseAccountData(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return AccountInfo.fromJson(parsed);
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
