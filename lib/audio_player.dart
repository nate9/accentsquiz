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

  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;

  get _durationText => _duration?.inSeconds?.toString() ?? '';
  get _positionText => _position?.inSeconds?.toString() ?? '';

  var localFilePath;
  bool isPlaying = false;

  void initAudioPlayer() {
    _audioPlayer = new AudioPlayer();
    _audioPlayer.durationHandler = (d) => setState((){
      _duration = d;
    });

    _audioPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });

    _audioPlayer.completionHandler = () {
      //TODO: On Completion code goes here
      setState(() {
        _position = _duration;
      });
    };

    _audioPlayer.errorHandler = (msg) {
      print('audioPlayer error : $msg');
      setState(() {
        isPlaying = false;
        _duration = new Duration(seconds: 0);
        _position = new Duration(seconds: 0);
      });
    };
  }

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
    await _audioPlayer.play(localFilePath, isLocal:true);
    setState(() {
      isPlaying = true;
    });
  }

  Future _pause() async {
    await _audioPlayer.pause();
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

  Widget _buildDuration() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          padding: EdgeInsets.all(36.00),
          child: new Slider(
              value: _position?.inMilliseconds?.toDouble() ?? 0.0,
              min: 0.0,
              max: _duration.inMilliseconds.toDouble()
          ),
        ),
        new Text(
          _position != null
              ? '${_positionText ?? ''} / ${_durationText ?? ''}'
              : _duration != null ? _durationText : '',
          style: new TextStyle(fontSize: 24.00),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton(),
          _buildDuration()
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }
}