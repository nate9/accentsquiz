import 'package:flutter/material.dart';
import 'audio_player.dart';

class DraggableAccentCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(50.0),
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        border: new Border.all(
            color: Colors.black,
            width: 5.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.yellow,
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(Icons.account_circle, size: 96.00),
          new AudioPlayerWidget(),
        ],
      ),
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
          setState(() => this.mDragState = DragState.none);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Text("Thanks for playing"),
                actions: <Widget>[
                  new RaisedButton(
                    child: new Text("You're welcome"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    })
                ],
              );
            }
          );
        },
        onLeave: (_) => setState(() => this.mDragState = DragState.none),
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