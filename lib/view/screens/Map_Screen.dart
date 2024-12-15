import 'dart:developer';

import 'package:dinenear_app/resources/customwidgets/custom_bottom_sheet.dart';
import 'package:dinenear_app/view/screens/Select_Radius.dart';
import 'package:dinenear_app/view/screens/Splash_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../resources/colors/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  final _locationController = TextEditingController();
  final Set<Marker> _markers = {};

  // ye call hoga directly location ko fetch karne k liye

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      _getCurrentLocation();
    });
  }


  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled.');
        return;
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permissions are denied.');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        log('Location permissions are permanently denied.');
        return;
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Fetch address from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Update marker and camera position
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentPosition,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );

        // Update the address in the text field
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          _locationController.text =
          '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        } else {
          _locationController.text = "Address not found";
        }
      });
      _mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    } catch (e) {
      log('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Select your Location',style: GoogleFonts.openSans(
          fontSize: 17
        ),),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height / 15,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Container(
                  height: MediaQuery.of(context).size.height *0.50,
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition,
                      zoom: 13.0,
                    ),
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
                ),
              // Address input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.circle_outlined),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintStyle: TextStyle(color: AppColor.textPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
                  ),
                ),
              ),
              // search icon wali textfield hai ye
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => show(),
                    icon: Icon(Icons.add),
                  ),
                  filled: true,
                  hintText: "Place your radius?",
                  fillColor: Colors.grey[200],
                  hintStyle: TextStyle(color: AppColor.textPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
                ),),
              ),
              // Submit button
              // yaha aik search
              ElevatedButton(
                  child: Text('Find a Restaurant'),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectRadiusScreen(),))),
            ],
          ),
        ),
      ),
    );
  }

  void show() {
  showModalBottomSheet(context: context,
    builder: (BuildContext context){
    return CustomBottomSheet();
  });
  }
}
