import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}
List<Marker> allMarkers = [];

class _MapState extends State<Map> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState(){
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('my location'),
      draggable: false,
      position: LatLng(53.344471,-6.259217),
      infoWindow: InfoWindow(title: 'My location'),
    ));

    allMarkers.add(Marker(
      markerId: MarkerId('Walter'),
      draggable: false,
      position: LatLng(53.343542,-6.251029),
      infoWindow: InfoWindow(title: 'Walter'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Map'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target:  LatLng(53.3438, -6.2546),
            zoom: 15.0,
          ),
          markers: Set.from(allMarkers),
        ),
    );

  }
}