import 'package:flutter/material.dart';
import 'audio_player.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _likedVoice() {

  }

  void _dislikedVoice() {

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            borderRadius: new BorderRadius.circular(25.0),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.account_circle, size: 96.00),
              new AudioPlayerWidget(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                      child: Icon(Icons.check),
                      color: Colors.green,
                      onPressed: _likedVoice),
                  new MaterialButton(
                      child: Icon(Icons.cancel),
                      color: Colors.red,
                      onPressed: _dislikedVoice),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
