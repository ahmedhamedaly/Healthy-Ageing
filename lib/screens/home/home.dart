import 'package:Healthy_Ageing/screens/messaging/matches.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/services/swipe/cards.dart';
import 'package:Healthy_Ageing/services/swipe/matches.dart';
import 'package:Healthy_Ageing/services/auth.dart';
import 'package:Healthy_Ageing/models/profiles.dart';

import '../../services/swipe/cards.dart';
import '../profile_settings/dog_lover_profile.dart';
import '../profile_settings/dog_owner_profile.dart';


final MatchEngine matchEngine = new MatchEngine(
    matches: demoProfiles.map((Profile profile) {
      return Match(profile: profile);
    }).toList());


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
String userType = 'owner';

class _HomeState extends State<Home> {

  final dogLoverProfile = new DogLoverProfile();
  final dogOwnerProfile = new OwnerProfile();

  Match match = new Match();

  final AuthService _auth = AuthService();

  void moveToProfilePage() async {
    bool a = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => userType == 'owner' ? dogOwnerProfile : dogLoverProfile)
    );
    updateInfoPress(a);
  }

  void updateInfoPress(bool a) {
    setState(() => infoPress = a);
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
          if (userType == 'owner') {
            dogOwnerProfile.initProfile();
          } else {
            dogLoverProfile.initProfile();
          }
          moveToProfilePage();
          _auth.signOut();
          }

      ),
      title: new Icon(
        Icons.dashboard,
        size: 30.0,
        color: Colors.teal,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Matches()),
            );
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
                  setState(() {
                    index+=1;
                  });
                  matchEngine.currentMatch.nope();
                },
              ),
              new RoundIconButton.large(
                icon: Icons.check,
                iconColor: Colors.green,
                onPressed: () {
                  setState(() {
                    index += 1;
                  });
                  matchEngine.currentMatch.like();
                },
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: infoPress == true ? null : new CardStack(
        matchEngine: matchEngine,
      ),
      bottomNavigationBar: _buildBottomBar(),

    );
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
