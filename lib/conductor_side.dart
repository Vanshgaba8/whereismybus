import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'mymap.dart';
import 'newmaps.dart';
import 'firebase_options.dart';
//import 'package:google_map_live/mymap.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class ConductorSide extends StatefulWidget {
  @override
  _ConductorSideState createState() => _ConductorSideState();
}

class _ConductorSideState extends State<ConductorSide> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  String? selectedBusNumber = '';
  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  List<String> busNumbers = [];
  List<String> subStops = [];

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _getLocation();
    // location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'user'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conductor Side'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('add my location')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  // MyMap(snapshot.data!.docs[index].id)));
                                  LatLngToScreenPointPage("user1")));
                        },
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'user'
      }, SetOptions(merge: true));
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

_requestPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    print('done');
  } else if (status.isDenied) {
    _requestPermission();
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}
