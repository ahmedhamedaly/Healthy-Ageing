import 'dart:io';

import 'package:Healthy_Ageing/screens/messaging/matches.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/services/swipe/cards.dart';
import 'package:Healthy_Ageing/services/swipe/matches.dart';
import 'package:Healthy_Ageing/services/auth.dart';
import 'package:Healthy_Ageing/models/profiles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';

import '../../services/swipe/cards.dart';
import '../profile_settings/dog_lover_profile.dart';
import '../profile_settings/dog_owner_profile.dart';

List<Profile> dbProfiles = [];
MatchEngine matchEngine;


class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  void setInfoPress(bool a) {
    infoPress = a;
    print(infoPress);
  }

  @override
  _HomeState createState() => _HomeState();
}

bool infoPress = false;
String userID = " ";
 String petOwner = "false";


class _HomeState extends State<Home> {

  final dogLoverProfile = new DogLoverProfile();
  final dogOwnerProfile = new OwnerProfile();

  Match match = new Match();

  final AuthService _auth = AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void moveToProfilePage() async {
    bool a = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => petOwner == "true" ? dogOwnerProfile : dogLoverProfile)
    );
    updateInfoPress(a);
  }

  void moveToMatchPage() async {
    bool a = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Matches()),
    );
    updateInfoPress(a);
  }

  void updateInfoPress(bool a) {
    setState(() => infoPress = a);
  }

  Future<String> getUserID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    print("User id =" + uid);
    return uid;
  }

  void getReference() async {
    var currentUserID = await getUserID();
    final profileRef = FirebaseDatabase.instance.reference().child('users').child(currentUserID);
    profileRef.once().then((DataSnapshot snapshot) {
      petOwner = snapshot.value["isPetOwner"];
    });
    if (petOwner == "true") {
      dogOwnerProfile.initProfile(currentUserID);
    } else {
      dogLoverProfile.initProfile(currentUserID);
    }
    moveToProfilePage();
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff289eff),
      elevation: 0.0,
      centerTitle: true,
      leading: new IconButton(
        icon: new Icon(
          Icons.settings,
          color: Colors.black12,
          size: 30.0,
        ),
          // Within the `FirstRoute` widget
          onPressed: () {
          setState(() {
              infoPress = true;
             });
            getReference();
          }

      ),
      title:Text("Tender",
  style: TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  ),
),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.markunread,
            color: Colors.black12,
            size: 30.0,
          ),
          onPressed: () {
            setState(() {
              infoPress = true;
            });
            //_auth.signOut();
            moveToMatchPage();
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
        color: Colors.white,
        elevation: 0.0,

        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                onPressed: () {

                  //matchEngine.currentMatch.nope();
                },
              ),
              new RoundIconButton.large(
                icon: Icons.check,
                iconColor: Colors.green,
                onPressed: () {

                  //matchEngine.currentMatch.like();
                },
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    // TODO RUN THIS BEFORE BUILD
    setupProfiles();
  }

  Future setupProfiles() async {
    var db = FirebaseDatabase.instance.reference().child("users");
    await db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        // add profiles from db to list
        if (values['isPetOwner']) {
          print("here");
          dbProfiles.add(new Profile(bio: values['bio'], distance: values['age'].toString(), name: values['firstName'], photos: [
            "assets/photo_1.jpg",
            "assets/photo_2.jpg",
            "assets/photo_3.jpg",
            "assets/photo_4.jpg",
            "assets/photo_3.jpg",
            "assets/photo_2.jpg",
            "assets/photo_1.jpg",
          ],));
          //print(values["age"].toString());
        }});




    });


  }

   Widget ProfileFutureBuilder() {
    return FutureBuilder(
      future: setupProfiles(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState !=
                 ConnectionState.done || projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }

    matchEngine = new MatchEngine(
    matches: dbProfiles.map((Profile profile) {
      return Match(profile: profile);
    }).toList()
);

        return new CardStack(
          matchEngine: matchEngine,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //if (dbProfiles.length > 0) {
     // print(dbProfiles.length);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: infoPress == true ? null : ProfileFutureBuilder(),
        bottomNavigationBar: _buildBottomBar(),
      );
    //} else return Scaffold(
    //  backgroundColor: Colors.white,
    //  appBar: _buildAppBar(),
    //  body: Container(),
    //  bottomNavigationBar: _buildBottomBar(),
    //);
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 100.0;

  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            new BoxShadow(color: const Color(0x11000000), blurRadius: 10.0),
          ]),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
