// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
//
// class LocationTracker extends StatefulWidget {
//   @override
//   _LocationTrackerState createState() => _LocationTrackerState();
// }
//
// class _LocationTrackerState extends State<LocationTracker> {
//   String currentAddress = 'Fetching location...';
//   double latitude = 0.0;
//   double longitude = 0.0;
//   var userid;
//   bool isLocationTrackingActive = false; // Track location tracking state
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void startLocationTracking() {
//     Timer.periodic(Duration(seconds: 5), (timer) {
//       _getLocation();
//     });
//     setState(() {
//       isLocationTrackingActive = true;
//     });
//   }
//
//   // Stop location tracking
//   void stopLocationTracking() {
//     setState(() {
//       isLocationTrackingActive = false;
//     });
//   }
//
//   Future<void> _getLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userid = (prefs.getString('userid') ?? "");
//     print("userid....$userid");
//     print(currentAddress);
//     try {
//       // Get the user's current location
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       setState(() {
//         latitude = position.latitude;
//         longitude = position.longitude;
//       });
//
//       // Convert coordinates to an address
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(latitude, longitude);
//
//       if (placemarks != null && placemarks.isNotEmpty) {
//         Placemark placemark = placemarks[0];
//         setState(() {
//           currentAddress =
//           "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}";
//         });
//       } else {
//         setState(() {
//           currentAddress = 'Address not found';
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         currentAddress = 'Error fetching location';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Tracker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Latitude: $latitude',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               'Longitude: $longitude',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               'Address: $currentAddress',
//               style: TextStyle(fontSize: 20),
//             ),
//             ElevatedButton(
//               child: Text(
//                 isLocationTrackingActive ? 'Stop Tracking' : 'Start Tracking',
//               ),
//               onPressed: () {
//                 if (isLocationTrackingActive) {
//                   stopLocationTracking();
//                 } else {
//                   startLocationTracking();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
