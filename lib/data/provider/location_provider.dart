import 'dart:convert';
import 'dart:developer';

import 'package:dinenear_app/model/Map_Model.dart';
import 'package:dinenear_app/viewmodel/services/Map_Api_Services.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends ChangeNotifier {
  LatLng _currentPosition = LatLng(0.0, 0.0);
  LatLng get currentPosition => _currentPosition;

  final Set<Marker> _markers  ={};
  Set<Marker> get markers => _markers;

  String _currentAddress = "";
  String get currentAddress => _currentAddress;

  GoogleMapController? _mapController;
  set mapController(GoogleMapController controller){
    _mapController = controller;
    notifyListeners();
  }
  // yaha mene target location k lie variable or function ko rkhna hai
  String _targetAddress = '';
  String get targetAddress => _targetAddress;
  double _targetLatitude = 0.0;
  double get targetLatitude => _targetLatitude;
  double _targetLongitude = 0.0;
  double get targetLongitude => _targetLongitude;

  void updateSelectedLocation(String address, double latitude, double longitude){
    _targetAddress = address;
    _targetLongitude =longitude;
    _targetLatitude = latitude;
    notifyListeners();
  }

  //api service yahan call krni hai api service ka future function b yahan hi banega
  final ApiService _apiService = ApiService();
  // yahan pr api key dalni hai jisko use krke mene waha maps ko call krna ha
  String _apikey = "AIzaSyBlxJRveTb3NQJ4NM7IUEr-f6va5NwQBWU";
  // Ye location fetching etc pura function hai with it's logics
  Future<void> fetchCurrentLocation() async{
    try{
      //check permisssion is disable
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(!serviceEnabled){
        log('Location services are disabled');
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission  = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied){
          log('Location permissions are denied');
          return;
      }}
      if(permission == LocationPermission.deniedForever){
        log('Locations are permanently denied');
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high)
      );
      List <Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.clear();
      _markers.add(
        Marker(
        markerId:MarkerId('Current location'),
        position: _currentPosition,
        infoWindow: InfoWindow(title: 'Your location'),
        ),
      );
      _currentAddress = placemarks.isNotEmpty
          ? '${placemarks.first.name}, ${placemarks.first.subLocality}, ${placemarks.first.locality},'
          ' ${placemarks.first.country}'
          : "Address not found";

      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      notifyListeners();
    }//try
    catch (e){
      log("Error fetching location: $e");
    }
  }

  //yhan api service wala function lagega pura
  // Future<void> submitMapData({
  //   required double radius,
  //   required String place,
  //   required double latitude,
  //   required double longitude,
  // }) async {
  //   MapModel mapData = MapModel(
  //       radius: radius,
  //       place: place,
  //       latitude: latitude,
  //       longitude: longitude
  //   );
  // bool success = await _apiService.createMap(mapData);
  // if(success){
  //   print('Map data created');
  // } else{
  //   print('failed');
  // }
  // }

  // yahan mene maps ko restrict karna hai k srf restraunts ko hi pick kare bas

  Future<void> fetchNearbyRestaurants() async {
    final String baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
    final String url =
        "$baseUrl?location=${_currentPosition.latitude},${_currentPosition.longitude}&radius=1500&type=restaurant&key=$_apikey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['results'] != null) {
          final List results = data['results'];

          _markers.clear();

          for (var place in results) {
            if (place['geometry'] != null &&
                place['geometry']['location'] != null &&
                place['place_id'] != null) {
              final LatLng location = LatLng(
                place['geometry']['location']['lat'],
                place['geometry']['location']['lng'],
              );

              _markers.add(
                Marker(
                  markerId: MarkerId(place['place_id']),
                  position: location,
                  infoWindow: InfoWindow(
                    title: place['name'] ?? "Unknown Name",
                    snippet: place['vicinity'] ?? "No Address",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange,
                  ),
                ),
              );
            }
          }

          notifyListeners();
        } else {
          debugPrint("No results found in response.");
        }
      } else {
        debugPrint("Failed to fetch restaurants: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint('Error fetching nearby restaurants: $e');
    }
  }


}