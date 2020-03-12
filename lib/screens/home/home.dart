import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/services/swipe/cards.dart';
import 'package:Healthy_Ageing/services/swipe/matches.dart';
import 'package:Healthy_Ageing/services/auth.dart';
import 'package:Healthy_Ageing/models/profiles.dart';

final MatchEngine matchEngine = new MatchEngine(
    matches: demoProfiles.map((Profile profile) {
      return Match(profile: profile);
    }).toList());

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Match match = new Match();

  final AuthService _auth = AuthService();

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.brown[400],
      elevation: 0.0,
      centerTitle: true,
      leading: new IconButton(
        icon: new Icon(
          Icons.settings,
          color: Colors.black12,
          size: 30.0,
        ),
        onPressed: () async {
          // TODO
          // For now its logout
          await _auth.signOut();
        },
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
            // TODO
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
        color: Colors.brown[100],
        elevation: 0.0,
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
//              new RoundIconButton.small(
//                icon: Icons.refresh,
//                iconColor: Colors.orange,
//                onPressed: () {},
//              ),
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                onPressed: () {
                  matchEngine.currentMatch.nope();
                },
              ),
//              new RoundIconButton.small(
//                icon: Icons.star,
//                iconColor: Colors.blue,
//                onPressed: () {
//                  matchEngine.currentMatch.superLike();
//                },
//              ),
              new RoundIconButton.large(
                icon: Icons.check,
                iconColor: Colors.green,
                onPressed: () {
                  matchEngine.currentMatch.like();
                },
              ),
//              new RoundIconButton.small(
//                icon: Icons.lock,
//                iconColor: Colors.purple,
//                onPressed: () {},
//              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: _buildAppBar(),
      body: new CardStack(
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
