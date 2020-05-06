import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './balance_display.dart';
import './json_parse.dart';

void main() => runApp(BankApp());

class BankApp extends StatefulWidget {
  @override
  _BankAppState createState() => _BankAppState();
}

class _BankAppState extends State<BankApp> {
  // var returnedInfo;
  // @override
  // void initState() {
  //   fetchAccountData(http.Client()).then((info) {
  //     returnedInfo = info;
  //   });
  // }

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
                  ? BalanceDisplay(accountInfo: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }),
        // body: BalanceDisplay(
        //   accountInfo: returnedInfo,
        // ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              addAccountBalance(http.Client(), 500).whenComplete(() {
                setState(() {
                  fetchAccountData(http.Client());
                });
              });
            }),
      ),
    );
  }
}
