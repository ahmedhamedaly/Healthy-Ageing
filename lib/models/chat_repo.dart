import 'dart:async';

import 'package:Healthy_Ageing/models/user_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../utilities/constants.dart';
import '../utilities/serialization_util.dart';
import 'chatroom.dart';
import 'firebase_repo.dart';
import 'user.dart';

class ChatRepo {
  static ChatRepo _instance;

  final Firestore _firestore;

  final _chatUsersSubject = BehaviorSubject<List<User_Object>>();

  ChatRepo._internal(this._firestore);

  factory ChatRepo.getInstance() {
    if (_instance == null) {
      _instance = ChatRepo._internal(FirebaseRepo.getInstance().firestore);
      _instance._getChatUsersInternal();
    }
    return _instance;
  }

  void _getChatUsersInternal() {
    _firestore
        .collection(FirestorePaths.USERS_COLLECTION)
        .orderBy("displayName")
        .snapshots()
        .map((data) => Deserializer.deserializeUsers(data.documents))
        .listen((users) {
      _chatUsersSubject.sink.add(users);
    });
  }

  Stream<List<User_Object>> getChatUsers() {
    return _chatUsersSubject.stream;
  }

  Future<SelectedChatroom> getChatroom(String chatroomId, User_Object currentUser, User_Object otherUser) async {
    DocumentReference chatroomRef = _firestore.document(FirestorePaths.CHATROOMS_COLLECTION + "/" + chatroomId);
    if (chatroomRef != null) {
      List<User_Object> users = List(2);
      users[0] = otherUser;
      users[1] = currentUser;
      DocumentSnapshot chatroomData = await chatroomRef.get();
      try {
        return SelectedChatroom(chatroomId, otherUser.name);
      } catch (error) {
        print(error);
        return null;
      }
    }
    else {
      return null;
    }
  }

  Stream<List<Chatroom>> getChatroomsForUser(User_Object user) {
    DocumentReference userRef =
    _firestore.document(FirestorePaths.USERS_COLLECTION + "/" + user.uid);
    return _firestore
        .collection(FirestorePaths.CHATROOMS_COLLECTION)
        .where(
      "participants",
      arrayContains: userRef,
    )
        .snapshots()
        .map((data) => Deserializer.deserializeChatrooms(
        data.documents, _chatUsersSubject.value));
  }

  Stream<Chatroom> getMessagesForChatroom(String chatroomId) {
    return _firestore
        .collection(FirestorePaths.CHATROOMS_COLLECTION)
        .document(chatroomId)
        .snapshots()
        .map((data) {
      Chatroom chatroom = Deserializer.deserializeChatroomMessages(data, _chatUsersSubject.value);
      chatroom.messages.sort((message1, message2) => message1.timestamp.compareTo(message2.timestamp));
      return chatroom;
    });
  }

  Future<SelectedChatroom> startChatroomForUsers(List<User_Object> users) async {
    DocumentReference userRef = _firestore
        .collection(FirestorePaths.USERS_COLLECTION)
        .document(users[1].uid);
    QuerySnapshot queryResults = await _firestore
        .collection(FirestorePaths.CHATROOMS_COLLECTION)
        .where("participants", arrayContains: userRef)
        .getDocuments();
    DocumentReference otherUserRef = _firestore
        .collection(FirestorePaths.USERS_COLLECTION)
        .document(users[0].uid);
    DocumentSnapshot roomSnapshot = queryResults.documents.firstWhere((room) {
      return room.data["participants"].contains(otherUserRef);
    }, orElse: () => null);
    if (roomSnapshot != null) {
      return SelectedChatroom(roomSnapshot.documentID, users[0].name);
    } else {
      Map<String, dynamic> chatroomMap = Map<String, dynamic>();
      chatroomMap["messages"] = List<String>(0);
      List<DocumentReference> participants = List<DocumentReference>(2);
      participants[0] = otherUserRef;
      participants[1] = userRef;
      chatroomMap["participants"] = participants;
      DocumentReference reference = await _firestore
          .collection(FirestorePaths.CHATROOMS_COLLECTION)
          .add(chatroomMap);
      DocumentSnapshot chatroomSnapshot = await reference.get();
      return SelectedChatroom(chatroomSnapshot.documentID, users[0].name);
    }
  }

  Future<bool> sendMessageToChatroom(String chatroomId, User user, String message) async {
    try {
      DocumentReference authorRef = _firestore.collection(FirestorePaths.USERS_COLLECTION).document(user.uid);
      DocumentReference chatroomRef = _firestore.collection(FirestorePaths.CHATROOMS_COLLECTION).document(chatroomId);
      Map<String, dynamic> serializedMessage = {
        "author" : authorRef,
        "timestamp" : DateTime.now(),
        "value" : message
      };
      chatroomRef.updateData({
        "messages" : FieldValue.arrayUnion([serializedMessage])
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void dismiss() {
    _chatUsersSubject.close();
  }
}