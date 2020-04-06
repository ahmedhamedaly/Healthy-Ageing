import 'dart:io';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Healthy_Ageing/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
final databaseReference = FirebaseDatabase.instance.reference();

class Photos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotosState();
  }
}

class PhotosState extends State<Photos> {
  File file1 = null;
  File file2 = null;
  File file3 = null;
  String url =null;
  String url1 = null;
  String url2 = null;
  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file1 = file;
      _path = file.path;
    });
  }

  void _showPhotoLibrary1() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file2= file;
      _path1 = file.path;
    });
  }

  void _showPhotoLibrary2() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
       file3 = file;
      _path2 = file.path;
    });
  }

  void _showOptions(BuildContext context, int path) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      switch (path) {
                        case 0:
                          _showPhotoLibrary();
                          break;
                        case 1:
                          _showPhotoLibrary1();
                          break;
                        case 2:
                          _showPhotoLibrary2();
                          break;
                      }
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  String _path = null;
  String _path1 = null;
  String _path2 = null;
  StorageReference firebaseStorageRef;
  StorageReference firebaseStorageRef1;
  StorageReference firebaseStorageRef2;
  void createRecord() async {

    databaseReference.child("profile pictures").set({
      'picture1': _path,
      'picture2': _path1,
      'picture3': _path2,
    });}

  Future uploadPic1(BuildContext context) async{
    if(file1!=null) {
      String fileName = basename(file1.path);
      firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(fileName);
      final StorageUploadTask uploadTask = firebaseStorageRef.putFile(file1);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      url = await taskSnapshot.ref.getDownloadURL();
      databaseReference.child("profile picture1").set({
        'picture': await firebaseStorageRef.getPath(),
        'url': url.toString(),

      });
    }
    }


  Future uploadPic2(BuildContext context) async{
    if(file2!=null) {
      String fileName = basename(file2.path);
      firebaseStorageRef1 = FirebaseStorage.instance.ref()
          .child(fileName);
      final StorageUploadTask uploadTask = firebaseStorageRef1.putFile(file2);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      url1 = await taskSnapshot.ref.getDownloadURL();
      databaseReference.child("profile picture2").set({
        'picture': await firebaseStorageRef1.getPath(),
        'url': url1.toString(),
      });

    }

  }
  Future uploadPic3(BuildContext context) async{
    if(file3!=null) {
      String fileName = basename(file3.path);
      firebaseStorageRef2 = FirebaseStorage.instance.ref()
          .child(fileName);
      final StorageUploadTask uploadTask = firebaseStorageRef2.putFile(file3);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      url2 = await taskSnapshot.ref.getDownloadURL();
      databaseReference.child("profile picture3").set({
        'picture': await firebaseStorageRef2.getPath(),
        'url': url2.toString(),
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pictures")),
        body: Container(
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
      child: SafeArea(
        child: Column(children: <Widget>[
          Container(
            height: 0,
            width: 500000,
          ),
          _path == null
              ? Expanded(
                  child: Image.asset(
                    "images/addPhoto.jpeg",
                    fit: BoxFit.fitWidth,
                  ))
                  : Expanded(
                  child: Image.file(
                    File(_path),
                    fit: BoxFit.fitWidth,
                  )),
              FlatButton(
                child: Text("Add Picture", style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () {
                  _showOptions(context, 0);
                },
              ),
              _path1 == null
                  ? Expanded(
                  child: Image.asset(
                    "images/addPhoto.jpeg",
                    fit: BoxFit.fitWidth,
                  ))
                  : Expanded(child: Image.file(File(_path1))),
              FlatButton(
                child: Text("Add Picture", style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () {
                  _showOptions(context, 1);
                },
              ),
              _path2 == null
                  ? Expanded(
                  child: Image.asset(
                    "images/addPhoto.jpeg",
                    fit: BoxFit.fitWidth,
                  ))
                  : Expanded(child: Image.file(File(_path2))),
              FlatButton(
                child: Text("Add Picture", style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () {
                  _showOptions(context, 2);
                },
              ),
              RaisedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    uploadPic1(context);
                    uploadPic2(context);
                    uploadPic3(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return Home();
                        }));
                  })
            ]),
          ),
        ));
  }
}
