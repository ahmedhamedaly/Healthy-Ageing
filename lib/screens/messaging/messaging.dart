import 'package:Healthy_Ageing/models/message.dart';
import 'package:Healthy_Ageing/screens/authenticate/sign_in.dart';
import 'package:Healthy_Ageing/services/auth.dart';
import 'package:flutter/material.dart';

//Screen for messaging with a matched user

class Messaging extends StatefulWidget {
  Messaging() {
    messages.add(new Message(
        DateTime.now().subtract(new Duration(hours: 1)), "Hi", false));
    messages.add(new Message(DateTime.now(), "Hi", true));
  }

  String name = 'Walter';
  List<Message> messages = new List();


  @override
  _MessagingState createState() => _MessagingState();
  final TextEditingController _textEditingController = IMTextEditingController();
}

class _MessagingState extends State<Messaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Messaging with: ' + widget.name),

          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text('Back'),
              onPressed: () {
                //TODO: Go Back
              },
            )
          ],
        ),

        body: Column(
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8),
                    child: TextField(
                      controller: widget._textEditingController,
                      focusNode: FocusNode(),
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.blueAccent,
                      decoration: InputDecoration(hintText: "Your message..."),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        _send(context, widget._textEditingController.text);
                      }),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  itemBuilder: (context, index) =>
                      _buildMessageItem(
                          widget.messages[widget.messages.length - 1 - index]),
                  itemCount: widget.messages.length,
                  reverse: true,
                ),
              ),
            )
          ],
        )
    );
  }

  Widget _buildMessageItem(Message message) {
    if (message.outgoing) {
      return Container(
        child: Text(
          message.value,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.end,
        ),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 0.0,
        ),
      );
    } else {
      return Container(
        child: Text(
          message.value,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 0.0,
        ),
      );
    }
  }

  void _send(BuildContext context, String text) {
    if (text.isNotEmpty) {
      //TODO: Send message
      widget._textEditingController.text = "";
    }
  }
}

class IMTextEditingController extends TextEditingController {}