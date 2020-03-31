import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Healthy_Ageing/screens/user_set_up.dart';
import 'package:Healthy_Ageing/screens/dog_owner_set_up.dart';
import 'package:Healthy_Ageing/utilities/constants.dart';

class DogOwnerOrUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DogOwnerOrUserScreenState();
  }
}

class DogOwnerOrUserScreenState extends State<DogOwnerOrUserScreen> {

  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF4751a6),
                      const Color(0xFF9e4bff),
                    ],
                    //stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'I am ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 100.0),
                      SizedBox(height: 80.0, width: 500,
                      child: new RaisedButton(
                          color: Color(0xff289eff),
                          child: Text(
                            'A Dog Lover',
                            style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),

                          ),
                          onPressed: () {

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return UserScreen();
                                }));
                          }),
                      ),

                      SizedBox(height: 160.0),

                      SizedBox(height: 80.0, width: 500,

                        child: new RaisedButton(
                            color: Color(0xff0080ff),
                            child: Text(
                              'A Dog Owner',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return DogOwnerScreen();
                                  }));

                            }),
                      ),





                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }


  }