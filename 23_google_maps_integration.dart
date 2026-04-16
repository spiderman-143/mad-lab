import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MapsIntegrationApp());

class MapsIntegrationApp extends StatelessWidget {
  const MapsIntegrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapsIntegrationHome(),
    );
  }
}

class MapsIntegrationHome extends StatefulWidget {
  const MapsIntegrationHome({super.key});

  @override
  State<MapsIntegrationHome> createState() => _MapsIntegrationHomeState();
}

class _MapsIntegrationHomeState extends State<MapsIntegrationHome> {
  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(12.9716, 77.5946),
    zoom: 12,
  );

  final Set<Marker> markers = const {
    Marker(
      markerId: MarkerId('bengaluru'),
      position: LatLng(12.9716, 77.5946),
      infoWindow: InfoWindow(title: 'Bengaluru'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Integration')),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: markers,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
