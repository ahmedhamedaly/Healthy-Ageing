import 'package:flutter/material.dart';
import 'package:set_up/photos.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _surname;
  int _age;
  String _area;
  String _bio;
  String _availablility;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        appBar: AppBar(title: Text("Set up")),
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
              key: _formKey ,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildName(),
                  _buildSurname(),
                  _buildAge(),
                  _buildArea(),
                  _buildBio(),
                 _buildAvailability(),
                  SizedBox(height: 100),
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
                        return Photos();
                        }));

                      }),
                ],
              ),
            )));
  }
}
