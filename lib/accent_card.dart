import 'package:flutter/material.dart';
import 'audio_player.dart';

class DraggableAccentCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Column(
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
                onPressed: null),
            new MaterialButton(
                child: Icon(Icons.cancel),
                color: Colors.red,
                onPressed: null),
          ],
        ),
      ],
    );
  }
}

enum DragState {left, none, right}

class CardsSectionDraggable extends StatefulWidget {

  @override
  State<CardsSectionDraggable> createState() => new CardsSectionDraggableState();
}

class CardsSectionDraggableState extends State<CardsSectionDraggable> {
  DragState mDragState = DragState.none;
  int cardsCounter = 0;
  List<Widget> cards = new List<Widget>();

  @override
  void initState()
  {
    super.initState();
    mDragState = DragState.none;
    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++)
    {
      cards.add(new Text("What's Up?"));
    }
  }

  Widget _buildDraggableCard() {
    return new Align(
      alignment: new Alignment(0.0, 0.0),
      child: new Draggable(
        child: new SizedBox.fromSize(
          size: new Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.6),
          child: new DraggableAccentCard(),
        ),
        feedback: new SizedBox.fromSize(
          size: new Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.6),
          child: new DraggableAccentCard(),
        ),
        childWhenDragging: new Container(),
      ),
    );
  }

  Widget _buildDragTargets() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        dragTarget(Colors.red, DragState.left),
        new Flexible(flex: 2, child: new Container()),
        dragTarget(Colors.green,  DragState.right),
      ],
    );
  }

  Widget dragTarget(Color onHover, DragState dragState) {
    return new Flexible(
      flex: 1,
      child: new DragTarget(
        builder: (_, __, ___) {
          return new Container(
            color: this.mDragState == dragState ? onHover : Colors.grey);
        },
        onWillAccept: (_) {
          setState(() => this.mDragState = dragState);
          return true;
        },
        onAccept: (_) {
          //TODO: Animations!
          //TODO: Swap cards
          setState(() => this.mDragState = dragState);
        },
        onLeave: (_) => setState(() => this.mDragState = dragState),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Stack(
        children: <Widget>[
          _buildDragTargets(),
          _buildDraggableCard()
        ],
      ),
    );
  }
}



/*
new Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
new Icon(Icons.account_circle, size: 96.00),
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
)*/
