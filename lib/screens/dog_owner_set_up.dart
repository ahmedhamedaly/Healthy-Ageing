import 'package:Healthy_Ageing/screens/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Healthy_Ageing/screens/user_or_dog_owner.dart';
import 'package:geolocator/geolocator.dart';
<<<<<<< HEAD
=======
import 'package:Healthy_Ageing/utilities/constants.dart';
>>>>>>> 8c549ac24ffe2c95b1c8d2f10139a74d859ef23a

class DogOwnerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DogOwnerScreenState();
  }
}

class DogOwnerScreenState extends State<DogOwnerScreen> {
  String _dogname;
  String _dognickname;
  String _breed;
  String _dogage;
  String _area;
  String _bio;
  String _availablility;
  bool _location = false;
  String _isTick = "";
  Position _currentPosition;
  String _challenge;
  String _owner;
  String _occupation;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name of the Dog'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value) {
        _dogname = value;
      },
    );
  }

  Widget _buildBreed() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Breed of the Dog'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Breed is required';
        }
        return null;
      },
      onSaved: (String value) {
        _breed = value;
      },
    );
  }
  Widget _ownerUser() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Who owns the dog'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'owner is required';
        }
        return null;
      },
      onSaved: (String value) {
        _owner = value;
      },
    );
  }

  Widget _work() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Your occupation'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'occupation is required';
        }
        return null;
      },
      onSaved: (String value) {
        _occupation = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age of the dog'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int age = int.tryParse(value);
        if (age == null || age <= 0) {
          return 'Age is required';
        }
        return null;
      },
      onSaved: (String value) {
        _dogage = value;
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
  Widget _challengeUser() {
    return TextFormField(
      maxLength: 180,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(labelText: 'What about pet ownership is challenging'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onSaved: (String value) {
        _challenge = value;
      },
    );
  }


  Widget _buildAvailability() {
    return TextFormField(
      maxLength: 50,
      decoration:
      InputDecoration(labelText: 'When is the dog free to hang (optional)'),
      onSaved: (String value) {
        _availablility = value;
      },
    );
  }

  Widget _nickname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nickname (if any)'),
      onSaved: (String value) {
        _dognickname = value;
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
                    colors: [CustomAppColours.scheme1Color1,
                      CustomAppColours.scheme1Color2,
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
                    key: _formKey1,
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
                        _buildName(),
                        SizedBox(height: 30.0),
                        _nickname(),
                        SizedBox(height: 30.0),
                        _buildBreed(),
                        SizedBox(height: 30.0),
                        _buildAge(),
                        //SizedBox(height: 30.0),
                       // _buildArea(),
                        SizedBox(height: 30.0),
                        _buildBio(),
                        SizedBox(height: 30.0),
                        _challengeUser(),
                        SizedBox(height: 30.0),
                        _work(),
                        SizedBox(height: 30.0),
                        _ownerUser(),
                        SizedBox(height: 30.0),
                        _buildAvailability(),
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
                              if (!_formKey1.currentState.validate() || _location == false) {
                                return;
                              }
                              _formKey1.currentState.save();
                              _getCurrentLocation();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
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
      ),
    );
  }
}