import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';


class AudioPlayerWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayerWidget> {

  AudioPlayer audioPlayer = new AudioPlayer();
  var localFilePath;
  bool isPlaying = false;

  Future _loadFile() async {
    final bytes = await _loadFileBytes();
    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/english1.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    }
  }

  Future<Uint8List> _loadFileBytes() async {
    final data = await rootBundle.load('assets/english1.mp3');
    final bytes = data.buffer.asUint8List();
    return bytes;
  }

  Future _play() async {
    print("Playing File");
    await _loadFile();
    await audioPlayer.play(localFilePath, isLocal:true);
    setState(() {
      isPlaying = true;
    });
  }

  Future _pause() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  Widget _buildButton() {
    if(isPlaying) {
      return new MaterialButton(
        child: new Icon(Icons.pause, size: 48.00),
        onPressed: _pause,
      );
    } else {
      return new MaterialButton(
        child: new Icon(Icons.play_arrow, size: 48.00),
        onPressed: _play,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _buildButton()
    );
  }
}