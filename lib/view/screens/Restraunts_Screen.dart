import 'dart:convert';

import 'package:dinenear_app/data/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class RestrauntsScreen extends StatefulWidget {
  const RestrauntsScreen({super.key});

  @override
  State<RestrauntsScreen> createState() => _RestrauntsScreenState();
}

class _RestrauntsScreenState extends State<RestrauntsScreen> {
  TextEditingController _restrauntsearchController = TextEditingController();
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  String _sessiontoken = '123';
  var uuid = Uuid();
  List<dynamic> _restrauntlist = [];

  @override
  @override
  void initState() {
    super.initState();
    // Fetch current location and nearby restaurants
    Provider.of<LocationProvider>(context, listen: false)
        .fetchCurrentLocation()
        .then((_) {
      Provider.of<LocationProvider>(context, listen: false)
          .fetchNearbyRestaurants();
    });
  }

  void onSearchChanged(){
    if(_sessiontoken == null){
      setState(() {
        _sessiontoken = uuid.v4();
      });
    }
    fetchRestraunt(_restrauntsearchController.text);
  }

  void fetchRestraunt(String query) async {
    //ye api key
    const String PLACE_API_KEY  = "AIzaSyBlxJRveTb3NQJ4NM7IUEr-f6va5NwQBWU";
    // API URL for place api then isme concat krna h take logic me request use kri jaske
    final String apiUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String requestUrl = '$apiUrl?input=$query&key=$PLACE_API_KEY&sessiontoken=$_sessiontoken&types=establishment';
    var response = await http.get(Uri.parse(requestUrl));
    if(response.statusCode == 200){
      setState(() {
        _restrauntlist = jsonDecode(response.body)['predictions'];
      });
    } else{
      throw Exception("Failed to load suggestions");
    }
  }

  void _RestrauntMarker() async{
    _markers.clear();
    for(var place in _restrauntlist){
      String address = place["description"];
      List<Location> locations = await locationFromAddress(address);
      if(locations.isNotEmpty){
        LatLng restaurantLatLng = LatLng(locations.last.latitude, locations.last.longitude);
        _markers.add(
            Marker(
                markerId: MarkerId(place['place_id']),
                position: restaurantLatLng,
                infoWindow: InfoWindow(title: place['description']),
            ));
      }
    }
  }

  @override
  void dispose() {
    _restrauntsearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapProvider.currentPosition,
                zoom: 15.0,
              ),
              markers: mapProvider.markers,
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapProvider.mapController = controller;
                mapProvider.fetchCurrentLocation();
              },
            ),
          )
        ],
      ),
    );
  }
}
