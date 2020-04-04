//List of matched users. Tapping one will open messaging to that user.
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:Healthy_Ageing/models/match.dart';
import 'package:Healthy_Ageing/screens/home/home.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/screens/messaging/messaging.dart';

class Matches extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MatchesState();
}

class MatchesState extends State<Matches> with SingleTickerProviderStateMixin {
  String uID = "1";
  List<Match> matches = new List<Match>();
  List<Match> dismatches = new List<Match>();
  List<Match> test = new List();
  TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getMatchData();
    getPendingData();
  }

  Future getMatchData() async {
    DatabaseReference reff = FirebaseDatabase.instance.reference().child(
        "users").child(uID);

    List<Match> matched = new List();
    List<String> matchID = new List();
    await reff.child("matched").once().then((DataSnapshot dataSnapShot) {
      Map<dynamic, dynamic> idMap = dataSnapShot.value;
      idMap.forEach((key, value) {
        matchID.add(value.toString());
      });
    });
    for (var element in matchID)
     {
      DatabaseReference id_reff = FirebaseDatabase.instance.reference().child(
          "users").child(element);
      await id_reff.once().then((DataSnapshot dataSnapShot) {
        String fname = dataSnapShot.value["firstName"].toString();
        String lname = dataSnapShot.value["surname"].toString();
        String pname = dataSnapShot.value["petName"].toString();
        String propic = dataSnapShot.value["profilePic"].toString();
        matched.add(new Match(id: element,
            OwnerName: fname + " " + lname,
            PetName: pname,
            profile_photo: propic,
            matched_back: true));
      });
    }

    matches = matched;

  }

  Future getPendingData() async {
    DatabaseReference reff = FirebaseDatabase.instance.reference().child(
        "users").child(uID);

    List<Match> pending = new List();
    List<String> pendingID = new List();
    await reff.child("pending").once().then((DataSnapshot dataSnapShot) {
      Map<dynamic, dynamic> idMap = dataSnapShot.value;
      idMap.forEach((key, value) {
        pendingID.add(value.toString());
      });
    });
    for (var element in pendingID)
     {
      DatabaseReference id_reff = FirebaseDatabase.instance.reference().child(
          "users").child(element);
      await id_reff.once().then((DataSnapshot dataSnapShot) {
        String fname = dataSnapShot.value["firstName"].toString();
        String lname = dataSnapShot.value["surname"].toString();
        String pname = dataSnapShot.value["petName"].toString();
        String propic = dataSnapShot.value["profilePic"].toString();
        pending.add(new Match(id: element,
            OwnerName: fname + " " + lname,
            PetName: pname,
            profile_photo: propic,
            matched_back: false));
      });
    }

    dismatches = pending;
  }

  Column _buildMatches(List<Match> matchList) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                      color: Colors.white,
                      child: ListTile(

                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                matchList[index].profile_photo),
                          ),

                          title: Text(matchList[index].OwnerName),
                          subtitle: Text(matchList[index].PetName),
                          trailing: (matchList[index].matched_back == true) ?
                          Icon(Icons.message) : Icon(Icons.hourglass_empty),
                          selected: true,
                          onTap: () {
                            if (matchList[index].matched_back == true) {
                              Navigator.of(context).push(
                                  MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        //TODO: have each of these stored, and input them
                                        return new Messaging(
                                            "Walter", "123", "5");
                                      })
                              );
                            }
                          }
                      )
                  );
              },
            )
        )
      ],
    );
  }

  Widget matchFutureBuilder() {
    return FutureBuilder(
      future: getMatchData(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return _buildMatches(matches);
      },
    );
  }

  Widget pendingFutureBuilder() {
    return FutureBuilder(
      future: getPendingData(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return _buildMatches(dismatches);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.blueAccent[400],
              elevation: 0.0,

              title: Text("Your Matches"),
              leading: IconButton(
                icon: Icon(Icons.navigate_before, color: Colors.black,),
                onPressed: () {
                  setState(() {
                    infoPress = false;
                  });
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                  labelColor: Theme
                      .of(context)
                      .indicatorColor,
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Icon(
                        Icons.favorite, size: 30, color: Colors.white)),
                    Tab(icon: Icon(
                        Icons.favorite_border, size: 30, color: Colors.white)),
                  ]
              ),
            ),
          ),
          body:
          //Container(
          //color: Colors.white,
          //child:
          TabBarView(

            controller: _tabController,
            children: [
              matchFutureBuilder(),
              pendingFutureBuilder(),
            ],
          ),
          //),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.update),
              onPressed: () {
                setState(() {
                  getMatchData();
                  getPendingData();
                });
              }
          ),

        )
    );
  }
}
