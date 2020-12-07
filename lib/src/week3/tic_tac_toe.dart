import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(const MyApp());
}

class Button {
  Button({this.state = 'free', this.color = Colors.green});

  String state;
  Color color;
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _player = '0';
  Color _colorButton = Colors.white;
  Color _color = Colors.purple;
  final List<Button> _list = <Button>[
    Button(),
    Button(),
    Button(),
    Button(),
    Button(),
    Button(),
    Button(),
    Button(),
    Button(),
  ];

  void changeColors(int index) {
    setState(
      () {
        if (_list[index].color == Colors.green) {
          _list[index].color = _color;
          _list[index].state = _player;
        }
        if (_player == 'x') {
          _color = Colors.purple;
          _player = '0';
        } else {
          _color = Colors.amberAccent;
          _player = 'x';
        }
      },
    );
  }

  void winColors(List<int> win) {
    if (win.isEmpty) {
      restart();
    }
    setState(() {
      for (int i = 0; i < 9; i++) {
        if (i != win[0] && i != win[1] && i != win[2])
          _list[i].color = Colors.green;
      }
    });
  }

  void keepScore(int index) {
    bool _check = false;
    changeColors(index);
    final List<int> win = <int>[];
    int _draw = 0;
    for (int i = 0; i < 9; i++)
      if (_list[i].color == Colors.green) {
        _draw++;
      }

    if (_list[0].color == _list[3].color &&
        _list[3].color == _list[6].color &&
        _list[6].color != Colors.green) {
      _check = true;
      win.add(0);
      win.add(3);
      win.add(6);
    }
    if (_list[1].color == _list[4].color &&
        _list[4].color == _list[7].color &&
        _list[7].color != Colors.green) {
      _check = true;
      win.add(1);
      win.add(4);
      win.add(7);
    }
    if (_list[2].color == _list[5].color &&
        _list[5].color == _list[8].color &&
        _list[8].color != Colors.green) {
      _check = true;
      win.add(2);
      win.add(5);
      win.add(8);
    }
    if (_list[0].color == _list[4].color &&
        _list[4].color == _list[8].color &&
        _list[8].color != Colors.green) {
      _check = true;
      win.add(0);
      win.add(4);
      win.add(8);
    }
    if (_list[2].color == _list[4].color &&
        _list[4].color == _list[6].color &&
        _list[6].color != Colors.green) {
      _check = true;
      win.add(2);
      win.add(4);
      win.add(6);
    }
    if (_list[0].color == _list[1].color &&
        _list[1].color == _list[2].color &&
        _list[2].color != Colors.green) {
      _check = true;
      win.add(0);
      win.add(1);
      win.add(2);
    }
    if (_list[3].color == _list[4].color &&
        _list[4].color == _list[5].color &&
        _list[5].color != Colors.green) {
      _check = true;
      win.add(3);
      win.add(4);
      win.add(5);
    }
    if (_list[6].color == _list[7].color &&
        _list[7].color == _list[8].color &&
        _list[8].color != Colors.green) {
      _check = true;
      win.add(6);
      win.add(7);
      win.add(8);
    }
    if (_draw == 0) {
      _check = true;
    }
    if (_check) {
      setState(() {
        _colorButton = Colors.black;
      });
      winColors(win);
    }
  }

  void restart() {
    for (int i = 0; i < 9; i++) {
      setState(
        () {
          _list[i].color = Colors.green;
          _list[i].state = 'free';
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('TIC-TAC-TOE'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            GridView.builder(
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: _list[index].color,
                  child: GestureDetector(
                    onTap: () {
                      keepScore(index);
                    },
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: 3),
            ),
            Positioned(
              bottom: 20,
              left: 18,
              right: 18,
              child: FlatButton(
                height: 50,
                onPressed: () {
                  restart();
                  setState(
                    () {
                      _colorButton = Colors.white;
                    },
                  );
                },
                child: Text(
                  'Restart',
                  style: TextStyle(color: _colorButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}