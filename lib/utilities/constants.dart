import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


class FirestorePaths {
  static const String ROOT_PATH = "";
  static const String USERS_COLLECTION = ROOT_PATH + "users";
  static const String CHATROOMS_COLLECTION = ROOT_PATH + "chatrooms";
  static const String USER_DOCUMENT = USERS_COLLECTION + "/{user_id}";
}