//List of matched users. Tapping one will open messaging to that user.
import 'package:Healthy_Ageing/models/match.dart';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:Healthy_Ageing/utilities/matches_store.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/screens/messaging/messaging.dart';
import 'package:Healthy_Ageing/models/user_object.dart';

class Matches extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MatchesState();
}

class MatchesState extends State<Matches>{
  List<Match> matches = getMatches();

  @override
  Widget build(BuildContext context){
    Column _buildMatches(List<Match> matchList){
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(matchList[index].name),
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                          //TODO: have each of these stored, and input them
                          return new Messaging("Walter", "123", "5");
                        })
                    );
                  }
                );
              },
            )
          )
        ],
      );
    }

    const double _imageSize = 20.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child:AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text("List of Matches"),
            leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.black,),
              onPressed: (){
                setState(() {
                  infoPress = false;
                });
                Navigator.pop(context);
              },
            ),
           bottom: TabBar(
             labelColor: Theme.of(context).indicatorColor,
             tabs: [
               Tab(icon: Icon(Icons.favorite_border, size: _imageSize)),
               Tab(icon: Icon(Icons.favorite, size: _imageSize)),
             ]
           ),
          ),
        ),
       body: Padding(
         padding: EdgeInsets.all(5.0),
         child: TabBarView(
            children: [
              _buildMatches(matches.toList()),
              Center(child: Icon(Icons.settings)),
            ],
          ),
        ),

      )
    );
  }
}