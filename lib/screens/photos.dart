import 'dart:io';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotosState();
  }
}

class PhotosState extends State<Photos> {
  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
    });
  }

  void _showPhotoLibrary1() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path1 = file.path;
    });
  }

  void _showPhotoLibrary2() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pictures")),
        body: Container(
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
                  onPressed: () {
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