import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String dog_name = "Oscar";
String person_first_name = "Jake";
String person_last_name = "O'Donavan";
String bio = " Busy pet owner and a busy puppy! / Oscar loves long walks and the beach.";
String location_text =  "Portmarnock";

class display_profile_screen extends StatefulWidget{
  State<StatefulWidget> createState(){
    return display_profile_state();
  }
}

class display_profile_state extends State<display_profile_screen>{
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // decoration for UI
          Container(
            height: 470,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
              gradient: LinearGradient(
                colors:[Color(0xFF73AEF5), Color(0xFF478DE0), Color(0xFF398AE5)],
                stops: [0.33, 0.66, 0.99],
              )
            ),
          ),
        ],
      )

    );
  }
}