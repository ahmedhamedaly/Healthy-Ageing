import 'package:Healthy_Ageing/models/user.dart';
import 'package:Healthy_Ageing/models/user_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chatroom.dart';
import '../models/message.dart';
import '../models/user.dart';

class Deserializer {

  static List<User_Object> deserializeUsersFromReference(List<DocumentReference> references, List<User_Object> users) {
    return users.where((item) => references.any((reference) => reference.documentID == item.uid)).toList();
  }

  static List<User_Object> deserializeUsers(List<DocumentSnapshot> users) {
    return users.map((document) => deserializeUser(document)).toList();
  }

  static User_Object deserializeUser(DocumentSnapshot document) {
    return User_Object(document['uid'], document['name']);
  }

  static List<Chatroom> deserializeChatrooms(List<DocumentSnapshot> chatrooms, List<User_Object> users) {
    return chatrooms.map((document) => deserializeChatroom(document, users)).toList();
  }

  static Chatroom deserializeChatroom(DocumentSnapshot document, List<User_Object> users) {
    List<DocumentReference> participantReferences = List<DocumentReference>(2);
    participantReferences[0] = document['participants'][0];
    participantReferences[1] = document['participants'][1];
    return Chatroom(deserializeUsersFromReference(participantReferences, users).toList(), List<Message>());
  }

  static Chatroom deserializeChatroomMessages(DocumentSnapshot document, List<User_Object> users) {
    List<DocumentReference> participantReferences = List<DocumentReference>(2);
    participantReferences[0] = document['participants'][0];
    participantReferences[1] = document['participants'][1];
    Chatroom chatroom = Chatroom(deserializeUsersFromReference(participantReferences, users).toList(), List<Message>());
    chatroom.messages.addAll(deserializeMessages(document['messages'], users));
    return chatroom;
  }

  static List<Message> deserializeMessages(List<dynamic> messages, List<User_Object> users) {
    return messages.map((data) {
      return deserializeMessage(Map<String, dynamic>.from(data), users);
    }).toList();
  }

  static Message deserializeMessage(Map<String, dynamic> document, List<User_Object> users) {
    DocumentReference authorReference = document['author'];
    User_Object author = users.firstWhere((user) => user.uid == authorReference.documentID);
    return Message(author, document['timestamp'], document['value']);
  }

}
