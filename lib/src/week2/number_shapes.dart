import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _input;
  String _message;
  String _error = null;

  //returns true if 'number' is
  //square, else false
  bool _verifySquare(int number) {
    return sqrt(number) - sqrt(number).floor() == 0;
  }

  // Returns true if 'number' is
  // triangular, else false
  static bool _verifyTriangular(int number) {
    if (number < 0) {
      return false;
    }
    // A Triangular number must be
    // sum of first n natural numbers
    int sum = 0;

    for (int n = 1; sum <= number; n++) {
      sum = sum + n;
      if (sum == number) return true;
    }
    return false;
  }

  //returns true if 'nr' is int
  //else false
  bool _isInt(String nr) {
    if (nr == null) {
      return false;
    }
    return int.tryParse(nr) != null;
  }

  //sets the text of the message and the error
  //according to the given number
  void _checkNumber(String number) {
    if (!_isInt(number)) {
      setState(
        () {
          _error = 'Give a number!';
          _message = 'Wrong input! Please give a number.';
        },
      );
    } else {
      setState(
        () {
          int _nmb = int.parse(number);
          _error = null;
          if (_verifySquare(_nmb) && _verifyTriangular(_nmb))
            _message = 'The number is both SQUARE and TRIANGULAR';
          else if (_verifySquare(_nmb))
            _message = 'The number is SQUARE';
          else if (_verifyTriangular(_nmb))
            _message = 'The number is TRIANGULAR';
          else
            _message = 'The number is neither TRIANGULAR or SQUARE';
        },
      );
    }
  }

  void showAlertDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      title: Text(_input),
      content: Text(_message),
    );
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'Please input a number to see if it is square or triangular:',
            style: TextStyle(fontSize: 30),
          ),
          TextField(
            decoration: InputDecoration(
              errorText: _error,
            ),
            onChanged: (String value) {
              setState(
                () {
                  _input = value;
                },
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          _checkNumber(_input);
          showAlertDialog(context);
        },
      ),
    );
  }
}
