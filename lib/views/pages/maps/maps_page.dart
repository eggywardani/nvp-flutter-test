import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/widgets/custom_button.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _selectedLocation; // Nullable to track if a location is selected
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker(const LatLng(
        37.42796133580664, -122.085749655962)); // Set initial marker
  }

  // Function to add/update marker at the selected location
  void _setMarker(LatLng location) {
    final marker = Marker(
      markerId: const MarkerId('selectedLocation'),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Selected Location',
      ),
    );

    setState(() {
      _markers.clear(); // Clear any previous markers
      _markers.add(marker);
      _selectedLocation = location; // Update selected location
    });
  }

  // Function to get the user's current location
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

    // Request permission and get location data
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final LatLng currentLocation = LatLng(
      position.latitude,
      position.longitude,
    );

    // Update camera position
    controller.animateCamera(CameraUpdate.newLatLng(currentLocation));

    // Add marker at the current location
    _setMarker(currentLocation);
  }

  // Callback for when the camera position changes
  void _onCameraMove(CameraPosition position) {
    _setMarker(position.target); // Update marker position
  }

  // Submit selected location and return to previous page
  void _submitLocation() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppLocalizations.of(context)?.selectLocation ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ??
                  const LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
            onCameraMove: _onCameraMove, // Track camera movement
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed:
                  _goToCurrentLocation, // Get current location on button press
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CustomButton(
              onPressed: _selectedLocation != null ? _submitLocation : null,
              label: AppLocalizations.of(context)?.submitLocation ?? '',
              backgroundColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
