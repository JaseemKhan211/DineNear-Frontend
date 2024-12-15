// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class LocationServices{
//   late GoogleMapController _mapController;
//   LatLng _currentPosition = const LatLng(0.0, 0.0);
//   final Set<Marker> _markers = {};
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         print('Location services are disabled.');
//         return;
//       }
//       // Check and request location permissions
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print('Location permissions are denied.');
//           return;
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         print('Location permissions are permanently denied.');
//         return;
//       }
//       // Get the current location
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );
//       // Update marker and camera position
//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('currentLocation'),
//             position: _currentPosition,
//             infoWindow: const InfoWindow(title: 'Your Location'),
//           ),
//         );
//       });
//       _mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
//     } catch (e) {
//       print('Error fetching location: $e');
//     }
//   }
//
// }
//
