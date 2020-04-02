import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';


class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();


  static LatLng Default = new LatLng(53.343792, -6.254572);
  LatLng myPos = Default;
  LatLng theirPos = Default;
  List<Marker> allMarkers = [Marker(
      markerId: MarkerId('default'),
      draggable: false,
      position: Default,
      visible: false,
  ),Marker(
      markerId: MarkerId('default'),
      draggable: false,
      position: Default,
      visible: false,
  )];

  final myDBRef = FirebaseDatabase.instance.reference().child("This should be a userID").child("Location");
  final theirDBRef = FirebaseDatabase.instance.reference().child("Another userID").child("Location");

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState(){
    super.initState();
    initMarker();



  }

  Future initMarker() async {
    await myDBRef.once().then((DataSnapshot dataSnapShot) {
      double myLat = double.parse(dataSnapShot.value["Latitude"].toString());
      double myLong = double.parse(dataSnapShot.value["Longitude"].toString());
      myPos = new LatLng(myLat, myLong);

    });
    print("finish dbaccess 1");
    await theirDBRef.once().then((DataSnapshot dataSnapShot) {
      double theirLat = double.parse(dataSnapShot.value["Latitude"].toString());
      double theirLong = double.parse(dataSnapShot.value["Longitude"].toString());
      theirPos = new LatLng(theirLat, theirLong);

    });
    print("finish dbaccess");

    this.setState(() {
      allMarkers[0] = Marker(
        markerId: MarkerId('my location'),
        draggable: false,
        position: myPos,
        infoWindow: InfoWindow(title: 'My location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        )
      );

      allMarkers[1] = Marker(
          markerId: MarkerId('Walter'),
          draggable: false,
          position: theirPos,
          infoWindow: InfoWindow(title: 'Walter'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          )
      );

    });

    theirDBRef.onChildChanged.listen((event) { updateTheirMarker();});
  }

  Future updateMyDatabase (double lat, double long) async {
    await myDBRef.set({
    'Latitude': lat,
    'Longitude': long
    });
    print('db update complete');
  }

  Future updateTheirMarker () async {
    await theirDBRef.once().then((DataSnapshot dataSnapShot) {
      double theirLat = double.parse(dataSnapShot.value["Latitude"].toString());
      double theirLong = double.parse(dataSnapShot.value["Longitude"].toString());
      theirPos = new LatLng(theirLat, theirLong);

    });

    this.setState(() {
      allMarkers[1] = Marker(
          markerId: MarkerId('Walter'),
          draggable: false,
          position: theirPos,
          infoWindow: InfoWindow(title: 'Walter'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          )
      );
    });

  }

  void updateMyMarker (double lat, double long){
    print("update my marker");
    LatLng latlng = LatLng(lat, long);
    this.setState(() {
      allMarkers[0] = Marker(
        markerId: MarkerId('my location'),
        draggable: false,
        position: latlng,
        infoWindow: InfoWindow(title: 'My location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          )
      );
    });
  }

  void getCurrentLocation() async {

  try{
    var location = await _locationTracker.getLocation();
    updateMyMarker(location.latitude, location.longitude);
    updateMyDatabase(location.latitude, location.longitude);

    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    _locationSubscription =_locationTracker.onLocationChanged.listen((LocationData newLocalData) async {
      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            target: LatLng(newLocalData.latitude, newLocalData.longitude),
            zoom: 14.00)));
        updateMyMarker(newLocalData.latitude, newLocalData.longitude);
        updateMyDatabase(newLocalData.latitude, newLocalData.longitude);
        //updateTheirMarker();
      }});

  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      debugPrint("Permission Denied");
    }
  }
  }

  @override
  void dispose() {
    if (_locationSubscription != null){
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[400],
          elevation: 0.0,
          title: Text('Map'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target:  myPos,
            zoom: 11.0,
          ),
          markers: Set.from(allMarkers),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: (){
          getCurrentLocation();
        }
      ),
    );

  }
}