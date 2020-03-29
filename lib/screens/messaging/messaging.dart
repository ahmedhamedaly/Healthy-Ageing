import 'package:Healthy_Ageing/models/message.dart';
import 'package:Healthy_Ageing/models/user_object.dart';
import 'package:Healthy_Ageing/screens/authenticate/sign_in.dart';
import 'package:Healthy_Ageing/screens/map/map.dart';
import 'package:Healthy_Ageing/services/auth.dart';
import 'package:Healthy_Ageing/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Screen for messaging with a matched user



class Messaging extends StatefulWidget {

  //TODO hook these up
  String name;
  String chatId;
  String peerId;
  //TODO: Get user Id
  String id = "5";
  Messaging(String name, String chatId, String PeerId) {
    this.name = name;
    this.chatId = chatId;
    this.peerId = peerId;
  }



  @override
  _MessagingState createState() => _MessagingState();
  final TextEditingController _textEditingController = IMTextEditingController();
}

class _MessagingState extends State<Messaging> {

  final TextEditingController textEditingController = new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  var listMessage;
  String id = "5";
  String name = 'Walter';
  String peerId = "5";
  String groupChatId = "1";
  List<Message> messages = new List();

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
              icon: Icon(Icons.map),
              label: Text('Map'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new Map();
                    })
                );
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
                        build(context);
                      }),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                )
              ],
            ),
                buildListMessage()
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
      onSendMessage(text, 0);
//      widget.messages.add(new Message(User_Object("123","Walter"), DateTime.now(), text, true));
//      setState((){});
//      widget._textEditingController.text = "";
//      Future.delayed(const Duration(milliseconds: 5000), () {
//        widget.messages.add(new Message(User_Object("123","Walter"), DateTime.now(), "Sure, that sounds great", false));
//        setState((){});
      };
    }

//
//  final bool isLoading;
//  final List<Message> messages;
//  final bool error;

//  _MessagingState._internal(this.isLoading, this.messages, {this.error = false});
//
//  factory _MessagingState.initial() => _MessagingState._internal(true, List<Message>(0));
//
//  factory _MessagingState.messages(List<Message> messages) => _MessagingState._internal(false, messages);
//
//  factory _MessagingState.error(_MessagingState state) => _MessagingState._internal(state.isLoading, state.messages, error: true);
  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
          } else {
            listMessage = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
          // Text
              ? Container(
            child: Text(
              document['content'],
              style: TextStyle(color: primaryColor),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
              : document['type'] == 1
          // Image
              ? Container(
            child: FlatButton(
              child: Material(
//                child: CachedNetworkImage(
//                  placeholder: (context, url) => Container(
//                    child: CircularProgressIndicator(
//                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                    ),
//                    width: 200.0,
//                    height: 200.0,
//                    padding: EdgeInsets.all(70.0),
//                    decoration: BoxDecoration(
//                      color: greyColor2,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(8.0),
//                      ),
//                    ),
//                  ),
//                  errorWidget: (context, url, error) => Material(
//                    child: Image.asset(
//                      'images/img_not_available.jpeg',
//                      width: 200.0,
//                      height: 200.0,
//                      fit: BoxFit.cover,
//                    ),
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(8.0),
//                    ),
//                    clipBehavior: Clip.hardEdge,
//                  ),
//                  imageUrl: document['content'],
//                  width: 200.0,
//                  height: 200.0,
//                  fit: BoxFit.cover,
//                ),
//                borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                clipBehavior: Clip.hardEdge,
              ),
//              onPressed: () {
//                Navigator.push(
//                    context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
//              },
              padding: EdgeInsets.all(0),
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
          // Sticker
              : Container(
            child: new Image.asset(
              'images/${document['content']}.gif',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
//                  child: CachedNetworkImage(
//                    placeholder: (context, url) => Container(
//                      child: CircularProgressIndicator(
//                        strokeWidth: 1.0,
//                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                      ),
//                      width: 35.0,
//                      height: 35.0,
//                      padding: EdgeInsets.all(10.0),
//                    ),
//                    imageUrl: peerAvatar,
//                    width: 35.0,
//                    height: 35.0,
//                    fit: BoxFit.cover,
//                  ),
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(18.0),
//                  ),
//                  clipBehavior: Clip.hardEdge,
                )
                    : Container(width: 35.0),
                document['type'] == 0
                    ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
                    : document['type'] == 1
                    ? Container(
                  child: FlatButton(
                    child: Material(
//                      child: CachedNetworkImage(
//                        placeholder: (context, url) => Container(
//                          child: CircularProgressIndicator(
//                            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                          ),
//                          width: 200.0,
//                          height: 200.0,
//                          padding: EdgeInsets.all(70.0),
//                          decoration: BoxDecoration(
//                            color: greyColor2,
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(8.0),
//                            ),
//                          ),
//                        ),
//                        errorWidget: (context, url, error) => Material(
//                          child: Image.asset(
//                            'images/img_not_available.jpeg',
//                            width: 200.0,
//                            height: 200.0,
//                            fit: BoxFit.cover,
//                          ),
//                          borderRadius: BorderRadius.all(
//                            Radius.circular(8.0),
//                          ),
//                          clipBehavior: Clip.hardEdge,
//                        ),
//                        imageUrl: document['content'],
//                        width: 200.0,
//                        height: 200.0,
//                        fit: BoxFit.cover,
//                      ),
//                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                      clipBehavior: Clip.hardEdge,
                    ),
//                    onPressed: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
//                    },
                    padding: EdgeInsets.all(0),
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                )
                    : Container(
                  child: new Image.asset(
                    'images/${document['content']}.gif',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
              child: Text(
               DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp'])).toIso8601String(),
                style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      //Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

}



class IMTextEditingController extends TextEditingController {}