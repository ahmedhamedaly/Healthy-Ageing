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

//Used in messaging; may move/remove later
Color themeColor = Color.fromRGBO(150, 150, 150, 1);
Color primaryColor = Color.fromRGBO(0, 0, 0, 1);
Color greyColor2 = Color.fromRGBO(100, 100, 100, 1);
Color greyColor = Color.fromRGBO(50, 50, 50, 1);

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