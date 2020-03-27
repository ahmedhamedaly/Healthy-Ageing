import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jack_set/user_or_dog_owner.dart';


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
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
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
                        SizedBox(height: 30.0),
                        _buildArea(),
                        SizedBox(height: 30.0),
                        _buildBio(),
                        SizedBox(height: 30.0),
                        _buildAvailability(),
                        RaisedButton(
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return;
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