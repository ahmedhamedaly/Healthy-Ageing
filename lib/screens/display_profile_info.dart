import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
          AppBar(
            backgroundColor: Colors.blueAccent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
          ),

          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: 400,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 0),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: PhotoView(
                            imageProvider: AssetImage('assets/mananddog.jpg'),
                            minScale: PhotoViewComputedScale.contained * 0.99,
                            maxScale:PhotoViewComputedScale.contained * 1.5,
                          ),
                        )
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color:Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          child: Text("0.5km away", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 170),
                          child: Container(
                            child: Text(dog_name + " & " + person_first_name + " " + person_last_name,
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0
                              )
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 520),
                            child: Icon(Icons.info_outline, color: Colors.lightBlueAccent, size:30),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 520, left: 10),
                            child: Text(bio,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 24,
                            ),),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 570, right: 5),
                            child: Icon(Icons.location_on, color: Colors.grey, size: 40),
                          ),

                        Container(
                          margin: EdgeInsets.only(top: 570, left: 7),
                          child: Text(location_text,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey.shade600
                          ),
                        ),
                      )
                    ],
                  ),
                ] ,
                  ),

            )
          ]
            ),
      )
      ]
    ),);
  }
}