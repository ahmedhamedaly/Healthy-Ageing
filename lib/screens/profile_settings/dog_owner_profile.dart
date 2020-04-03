import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; //have to run flutter get before
//running this code so the image selection works
import 'dart:async'; //need these too for the image selection to work
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

/*
  This class is for the Pet Owner profile
 */

//uninitalised variable for uploading user's own profile picture
File _image;

//variables for user's profile info
String ownerName = "";
String ownerSecondName = "";
String dogName = "";
String bio = "";
String area = "";
String uID = "";

final profileRef = FirebaseDatabase.instance.reference();
final locationRef = FirebaseDatabase.instance.reference().child('Another userID').child('Location');

class OwnerProfile extends StatefulWidget {
  OwnerProfile({Key key, this.title}) : super(key: key);

  final String title;

  Future initProfile(String id) async {
    uID = id;
    await profileRef.once().then((DataSnapshot snapshot) {
      ownerName = snapshot.value["Owner First Name"].toString();
      ownerSecondName = snapshot.value["Owner Second Name"].toString();
      dogName = snapshot.value["Dog Name"].toString();
      bio = snapshot.value["Bio"].toString();
      locationRef.once().then((DataSnapshot snap) {
        area = snap.value['Text'].toString();
      });
    });
  }

  @override
  _OwnerProfileState createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {

  bool pressed = false;

  //colours for profile page
  final Color color1 = Color(0xffFC5CF0);
  final Color color2 = Color(0xffFE8852);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
          icon: Icon(Icons.navigate_before, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context, pressed);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          //container for user profile picture
          Container(
            margin: EdgeInsets.only(top: 40, left: 10),
            //padding: EdgeInsets.only(top: 100),
            width: 300,
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _image == null? Image(image: AssetImage('assets/man-dog.jpg'), fit: BoxFit.cover) : Image.file(_image),
            ),
          ),

          //container for user name and age
          Container(
              margin: EdgeInsets.only(top: 40, left: 20)
          ),
          Text(dogName + " + " + ownerName, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.deepPurpleAccent,
          )),

          //row for user information
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              //container for user bio
              Container(
                  margin: EdgeInsets.only(top: 60)
              ),
              Text(bio, style: TextStyle (
                  fontSize: 24.0,
                  color: Colors.grey
              )),
            ],
          ),

          //edit user profile and preview user profile buttons
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(

                  //button for editing user info
                  onPressed: (){

                    //when pressed change screen to edit user info page
                    Navigator.of(context).push(_createRouteEdit());
                  },
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text("Edit"),
                    ],
                  ),
                ),
                RaisedButton (

                  //button for previewing user profile as it would look like to other users
                  //on the app
                  onPressed: (){

                    //when pressed change screen to preview user profile page
                    Navigator.of(context).push(_createRoutePreview());
                  },
                  color: Colors.white,
                  child: Column (
                    children: <Widget>[
                      Text("Preview"),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

//class for previewing the user's profile screen
class PreviewProfile extends StatefulWidget {
  PreviewProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PreviewProfileState createState() => _PreviewProfileState();
}

class _PreviewProfileState extends State<PreviewProfile> {

  Widget build(BuildContext context){


    final Color color1 = Color(0xffFC5CF0);
    final Color color2 = Color(0xffFE8852);

    return Scaffold(
      body: Stack (
        children: <Widget>[

          //some UI bits to make it look nice
          Container(
            height: 470,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                )
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          //container for previewing how the user's profile looks to other
          //users of the app
          Container(
              margin: const EdgeInsets.only(top: 80),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Expanded(
                    child: Stack (
                      children: <Widget>[
                        Container(
                          height: 400,
                          width: 400,
                          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 0),

                          //user's profile picture
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            //if statement to enable changing the user profile picture
                            //if the image variable is still uninitialised, the default picture
                            //woman.jpg is used
                            //else the user selected picture is rendered
                            child: _image == null? Image(image: AssetImage('assets/man-dog.jpg'), fit: BoxFit.cover) : Image.file(_image),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,

                          //other UI bits
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                            //shows the distance of the user, in this case 0 km
                            child: Text("0 km away", style: TextStyle(fontSize: 18.0)),
                          ),
                        ),

                        //UI bits to show the name and age of the user
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 170),
                          child: Container(
                            child: Text(ownerName + " " + ownerSecondName + " \nand " + dogName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.0
                                )
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            //information icon to indicate bio of user
                            Container(
                              margin: EdgeInsets.only(top: 540, right: 10),
                              child: Icon(Icons.info_outline, color: Colors.grey, size: 30),
                            ),

                            //container for bio of user
                            Container(
                              margin: EdgeInsets.only(top: 540, left: 10),
                              child: Text(bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 24,
                                ),),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            //location icon to indicate the area the user is in
                            Container(
                              margin: EdgeInsets.only(top: 590, right: 20),
                              child: Icon(Icons.location_on, color: Colors.grey, size: 40),
                            ),

                            //container for location of user
                            Container(
                              margin: EdgeInsets.only(top: 590),
                              child: Text(area,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey.shade600
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}

//class for the screen to edit the user's information
class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  //alert dialog box that pops up when
  //user wants to upload a new profile picture
  //it asks whether the user wants to take a picture
  //from the camera or upload one from the gallery
  Future _alertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Photo From:'),
          actions: <Widget>[

            //when this button is pressed
            //calls the function to handle taking a picture
            //from device camera
            FlatButton(
              child: const Text('Camera'),
              onPressed: () {
                getImageFromCamera();
              },
            ),

            //when this button is pressed
            //calls the function to handle uploading
            //a picture from device gallery
            FlatButton(
              child: const Text('Gallery'),
              onPressed: () {
                getImageFromGallery();
              },
            )
          ],
        );
      },
    );
  }

  //allows user to select an image from their
  //device gallery
  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      //initialises the _image variable to
      //the image selected from user's gallery
      _image = image;
    });
  }

  //allows user to take a picture using
  //the device camera
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {

      //intialises the _image variable to the
      //picture taken from camera
      _image = image;
    });
  }


  Widget build (BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[

          //prompt for the first name field
          Container(
            margin: EdgeInsets.only(top: 20, left: 40),
            child: Text (
              "Human's First Name",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),

          //field to allow user to change their first name
          //on their profile
          Container(
              margin: EdgeInsets.only(top: 30, left: 40),
              child: TextField(
                style: TextStyle(
                    fontSize: 40
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ownerName
                ),
                onSubmitted: (String value) async {
                  profileRef.update({
                    'Owner FirstName' : value
                  });
                  setState(() {
                    profileRef.once().then((DataSnapshot snapshot) {
                      ownerName = snapshot.value["Owner First Name"];
                    });
                  });
                },
              )
          ),

          //prompt for second name field
          Container(
            margin: EdgeInsets.only(top: 110, left: 40),
            child: Text(
              "Human's Second Name",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),

          //field to allow user to change
          //their second name on their profile
          Container(
            margin: EdgeInsets.only(top: 120, left: 40),
            child: TextField(
              style: TextStyle(
                  fontSize: 40
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ownerSecondName
              ),
              onSubmitted: (String value) async {
                profileRef.update({
                  'Owner Second Name' : value
                });
                setState(() {
                  profileRef.once().then((DataSnapshot snapshot) {
                    ownerSecondName = snapshot.value["Owner Second Name"];
                  });
                });
              },
            ),
          ),

          //prompt for user to change name of dog
          Container(
            margin: EdgeInsets.only(top: 200, left: 40),
            child: Text(
              "Dog's Name",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),

          //field to allow user to change the name of
          //dog
          Container(
              margin: EdgeInsets.only(top: 210, left: 40),
              child: TextField(
                style: TextStyle(
                    fontSize: 40
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: dogName
                ),
                onSubmitted: (String value) {
                  profileRef.update({
                    'Dog Name' : value
                  });
                  setState(() {
                    profileRef.once().then((DataSnapshot snapshot) {
                      dogName = snapshot.value["Dog Name"];
                    });
                  });
                },
              )
          ),

          //prompt for the bio field
          Container(
              margin: EdgeInsets.only(top: 290, left: 40),
              child: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              )
          ),

          //field to allow user to change their bio
          Container(
              margin: EdgeInsets.only(top: 300, left: 40),
              child: TextField(
                style: TextStyle(
                    fontSize: 40
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: bio
                ),
                onSubmitted: (String value) {
                  profileRef.update({
                    'Bio' : value
                  });
                  setState(() {
                    profileRef.once().then((DataSnapshot snapshot) {
                      bio = snapshot.value["Bio"];
                    });
                  });
                },
              )
          ),

          //prompt for location field
          Container(
            margin: EdgeInsets.only(top: 390, left: 40),
            child: Text(
              "Location",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),

          //field to allow user to change their area on their profile
          Container(
              margin: EdgeInsets.only(top: 400, left: 40),
              child: TextField(
                style: TextStyle(
                    fontSize: 40
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: area
                ),
                onSubmitted: (String value) {
                  locationRef.update({
                    'Text' : value
                  });
                  setState(() {
                    locationRef.once().then((DataSnapshot snapshot) {
                      area = snapshot.value["Text"];
                    });
                  });
                },
              )
          ),

          //prompt to change profile picture
          Container(
            margin: EdgeInsets.only(top: 490, left: 40),
            child: Text(
              'Change Profile Picture',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue
              ),
            ),
          ),

          //button with a photo icon
          Container(
            margin: EdgeInsets.only(top: 530, left: 40),
            child: FloatingActionButton(

              //when this button is pressed
              //it calls the above alertDialog class
              //to show the prompt to take a picture from
              //camera or from gallery
              onPressed: () {
                _alertDialog(context);
              },
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }
}


//route builder to change screen from landing screen to profile preview screen
Route _createRoutePreview() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PreviewProfile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRouteEdit() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => EditProfile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}