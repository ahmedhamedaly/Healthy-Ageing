//List of matched users. Tapping one will open messaging to that user.
import 'package:Healthy_Ageing/models/match.dart';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:Healthy_Ageing/utilities/matches_store.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/screens/messaging/messaging.dart';

class Matches extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MatchesState();
}

class MatchesState extends State<Matches> with SingleTickerProviderStateMixin{
  List<Match> matches = getMatches();
  List<Match> dismatches = getDisMatches();
  TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context){
    Column _buildMatches(List<Match> matchList){
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (BuildContext context, int index){
                return
                  Card(
                    color: Colors.white,
                    child: ListTile(

                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(matchList[index].profile_photo),
                      ),

                      title: Text(matchList[index].OwnerName),
                      subtitle: Text(matchList[index].PetName),
                      trailing: (matchList[index].matched_back == true) ?
                      Icon(Icons.message) :Icon(Icons.hourglass_empty) ,
                      selected: true,
                      onTap: (){
                      if  (matchList[index].matched_back == true) {
                       Navigator.of(context).push(
                           MaterialPageRoute<Null>(builder: (
                               BuildContext context) {
                             //TODO: have each of these stored, and input them
                             return new Messaging("Walter", "123", "5");
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

    const double _imageSize = 20.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child:AppBar(
            backgroundColor: Colors.blueAccent[400],
            elevation: 0.0,

            title: Text("Your Matches"),
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
             controller: _tabController,
             tabs: [
               Tab(icon: Icon(Icons.favorite, size:  30, color: Colors.white)),
               Tab(icon: Icon(Icons.favorite_border, size: 30, color: Colors.white)),
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
              _buildMatches(matches.toList()),
              _buildMatches(dismatches.toList()),
            ],
          ),
       //),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.update),
            onPressed: (){

            }
        ),

      )
    );
  }
}