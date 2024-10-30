import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/controllers/home_controller.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/views/widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final controller = Get.put(HomeController());

  final Set<Marker> _markers = {};

  /// Adds a marker to the map, with the given latitude, longitude, and name.
  void _addMarker(
      {required double lat, required double long, required String name}) {
    final marker = Marker(
      markerId: MarkerId(name), // Use a unique ID for each marker
      position: LatLng(lat, long),
      infoWindow: InfoWindow(
        title: name,
      ),
    );

    _markers.add(marker);
  }

  /// Function to set the camera position on the map
  CameraPosition zoomToCamera({required double lat, required double long}) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppLocalizations.of(context)?.myLocation ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: StreamBuilder<RegisterModel?>(
        stream: controller.getUserData(),
        builder:
            (BuildContext context, AsyncSnapshot<RegisterModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingWidget(),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            RegisterModel data = snapshot.data!;

            // Only add marker once when data is available
            if (_markers.isEmpty) {
              _addMarker(
                lat: data.latitude ?? 0.0,
                long: data.longitude ?? 0.0,
                name: data.name ?? 'Unknown',
              );
            }

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: zoomToCamera(
                lat: data.latitude ?? 0.0,
                long: data.longitude ?? 0.0,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
              },
            );
          } else {
            return const Center(
              child: Text('Location not available'),
            );
          }
        },
      ),
    );
  }
}
