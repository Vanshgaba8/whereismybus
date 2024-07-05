import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'tile_providers.dart';
import 'dart:math';
import 'package:latlong2/latlong.dart';

class LatLngToScreenPointPage extends StatefulWidget {
  final String documentId;

  LatLngToScreenPointPage(this.documentId);

  @override
  State<LatLngToScreenPointPage> createState() =>
      _LatLngToScreenPointPageState();
}

class _LatLngToScreenPointPageState extends State<LatLngToScreenPointPage> {
  static const double pointSize = 65;

  MapController mapController = MapController();

  LatLng? liveLocation;
  String? cityName;

  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    refreshLocation();
  }

  Future<void> refreshLocation() async {
    final snapshot =
        await _firestore.collection('location').doc(widget.documentId).get();
    final data = snapshot.data() as Map<String, dynamic>;
    liveLocation = LatLng(data['latitude'], data['longitude']);
    final placemarks = await placemarkFromCoordinates(
        liveLocation!.latitude, liveLocation!.longitude);
    cityName = placemarks.first.locality;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Where is my Bus')),
      body: Stack(
        children: [
          if (liveLocation != null)
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: liveLocation!,
                initialZoom: 11,
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      width: pointSize,
                      height: pointSize,
                      point: liveLocation!,
                      child: Column(
                        children: [
                          Text(cityName ?? ''),
                          Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          if (liveLocation == null) Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshLocation,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
