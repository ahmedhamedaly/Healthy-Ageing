import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:Healthy_Ageing/screens/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Healthy_Ageing/screens/user_or_dog_owner.dart';
import 'package:geolocator/geolocator.dart';


class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserScreenState();
  }
}

class UserScreenState extends State<UserScreen> {

  String _name;
  String _surname;
  int _age;
  String _area;
  String _bio;
  String _availablility;
  bool _location = false;
  String _isTick = "";
  Position _currentPosition;
  String _experience;
  String _pullingDog;
  String _comfort;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  Widget _buildName() {
    return TextFormField(

      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }
  Widget _buildSurname() {
    return TextFormField(

      decoration: InputDecoration(labelText: 'Surname'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Surname is required';
        }
        return null;
      },
      onSaved: (String value) {
        _surname = value;
      },
    );
  }
  Widget _buildAge() {
    return TextFormField(

      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (String value) {

        int age = int.tryParse(value);
        if (age == null || age <=0) {
          return 'Age is required';
        }
        return null;
      },
      onSaved: (String value) {
        _surname = value;
      },
    );
  }

  Widget _buildBio() {
    return TextFormField(
      maxLength: 180,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(labelText: 'Bio'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Bio is required';
        }
        return null;
      },
      onSaved: (String value) {
        _bio = value;
      },
    );
  }
  Widget _buildAvailability() {
    return TextFormField(
      maxLength: 50,
      decoration: InputDecoration(labelText: 'Availability (optional)'),
      onSaved: (String value) {
        _availablility = value;
      },
    );
  }
  Widget _experienceUser() {
    return TextFormField(
      maxLength: 100,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(labelText: 'What is your experience with animals'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Experience is required';
        }
        return null;
      },
      onSaved: (String value) {
        _experience = value;
      },
    );
  }

  Widget _comfortUser() {
    return TextFormField(
      maxLength: 50,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(labelText: 'How comfortable are you with dogs'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onSaved: (String value) {
        _comfort = value;
      },
    );
  }
  Widget _strengthUser() {
    return TextFormField(
      maxLength: 180,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(labelText: 'Are you able for a strong dog'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onSaved: (String value) {
        _pullingDog = value;
      },
    );
  }



  Widget _buildArea() {
    return TextFormField(

      decoration: InputDecoration(labelText: 'Area'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Area is required';
        }
        return null;
      },
      onSaved: (String value) {
        _area = value;
      },
    );
  }

  Widget _buildLocationCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _location,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                if(_location==false) {
                  _getCurrentLocation();
                }
                setState(() {
                  _location = value;

                });
              },
            ),
          ),
          Text(
            'I accept that Tender will use my Location',
          ),

        ],
      ),
    );
  }
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

      });
    }).catchError((e) {
      print(e);
    });
  }
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
                  child: Form(
                    key: _formKey ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                print('yes');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return DogOwnerOrUserScreen();
                                    }));
                              }),
                        ),
                        Text(
                          'Set Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildAge(),
                        //SizedBox(height: 30.0),
                       // _buildArea(),
                        SizedBox(height: 30.0),
                        _buildBio(),
                        SizedBox(height: 30.0),
                        _buildAvailability(),
                        SizedBox(height: 30.0),
                        _experienceUser(),
                        SizedBox(height: 30.0),
                        _comfortUser(),
                        SizedBox(height: 30.0),
                       _strengthUser(),
                        SizedBox(height: 30.0),
                        _buildLocationCheckBox(),
                        SizedBox(height: 10.0),
                        SizedBox(height: 30.0,width:300, child: Text("     *Location is required for matching*", style: TextStyle(color:
                        Colors.red),)),
                        RaisedButton(
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate() || _location == false) {
                                return;
                              }
                              _formKey.currentState.save();
                              _getCurrentLocation();
                              print(_currentPosition);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return Photos();
                                  }));

                            }),




                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }


}
