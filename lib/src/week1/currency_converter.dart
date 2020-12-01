import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  String error;
  String show = '';

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: const Text(
            'Currency convertor',
            style: TextStyle(height: 2, fontSize: 25),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Image.network(
              'https://play-lh.googleusercontent.com/vzikRNHRMzyZU2Qo8B0Hm_ZWVYDXVcFWjGMY6eucShzZPStF1xk4J7qmo41NzgCynRY',
              height: 200,
            ),
          ),
          Theme(
            data: ThemeData(
                primaryColor: Colors.green[200], hintColor: Colors.green[50]),
            child: TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: '   Enter the amount in EUR', errorText: error),
              onChanged: (String value) {
                setState(
                  () {
                    text = value;
                  },
                );
              },
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(
                () {
                  if (isNumeric(text)) {
                    error = null;
                    double nr = double.parse(text) * 4.50;
                    nr = double.parse(nr.toStringAsFixed(3));
                    show = '$nr RON';
                  } else
                    error = '   Give a number!';
                },
              );
            },
            color: Colors.lightGreen[100],
            textColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(color: Colors.white70),
            ),
            child: const Text(
              'Convert!',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Text(
            show,
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.grey[800],
              height: 2,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
