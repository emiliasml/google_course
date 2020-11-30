import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _error;
  String _hints = '';
  int _number = 1;
  String _givenNumberString = '';
  final Random _random = Random();
  String _button = 'Guess';

  void showAlertDialog(BuildContext context) {
    // set up the button
    final Widget tryAgainButton = FlatButton(
      child: const Text('Try again!'),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _hints = '';
          _button = 'Guess';
        });
      },
    );

    final Widget okButton = FlatButton(
      child: const Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text('You guessed right'),
      content: Text('It was $_number'),
      actions: <Widget>[
        tryAgainButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool verifyInt(String nr) {
    if (nr == null) {
      return false;
    }
    return int.tryParse(nr) != null;
  }

  Random rnd = Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Guess my number',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Text(
            "I'm thinking of a number between 1 and 100",
            style: TextStyle(
              fontSize: 25,
              height: 1.2,
              color: Colors.blueGrey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "It's your turn to guess my number!",
            style: TextStyle(fontSize: 25, color: Colors.blueGrey, height: 1.6),
          ),
          Text(
            _hints,
            style: const TextStyle(fontSize: 25),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                const Text(
                  'Try a number!',
                  style: TextStyle(fontSize: 30, height: 2.5),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    setState(
                      () {
                        _givenNumberString = value;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    hintText: 'Insert here',
                    errorText: _error,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    if (_button == 'Reset') {
                      setState(
                        () {
                          _hints = '';
                          _button = 'Guess';
                        },
                      );
                    } else {
                      if (verifyInt(_givenNumberString)) {
                        setState(
                          () {
                            _error = null;
                          },
                        );
                        if (int.parse(_givenNumberString) > _number)
                          setState(
                            () {
                              _hints = 'You tried ' +
                                  _givenNumberString +
                                  '\nTry lower!' +
                                  '$_number';
                            },
                          );
                        else if (int.parse(_givenNumberString) < _number)
                          setState(
                            () {
                              _hints = 'You tried ' +
                                  _givenNumberString +
                                  '\nTry higher!' +
                                  '$_number';
                            },
                          );
                        else {
                          setState(
                            () {
                              showAlertDialog(context);
                              _number = next(1, 100);
                              _hints = 'You tried ' +
                                  _givenNumberString +
                                  '\nYou guessed!';
                              _button = 'Reset';
                            },
                          );
                        }
                      } else {
                        setState(
                          () {
                            _error = 'Give a number!';
                          },
                        );
                      }
                    }
                  },
                  child: Text(_button),
                  color: Colors.blueGrey[200],
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
