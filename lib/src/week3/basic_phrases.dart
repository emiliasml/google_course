import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
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
  AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    // create this only once
    _audioCache = AudioCache(
        prefix: 'audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic phrases'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  onPressed: () {
                    _audioCache.play('HappyEaster.mp3');
                  },
                  child: const Text(
                    'Happy Easter',
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.deepPurple,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
