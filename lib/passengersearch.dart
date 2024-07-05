import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'newmaps.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  String from = '';
  String to = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Buses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  from = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'From',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            TextField(
              onChanged: (value) {
                setState(() {
                  to = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LatLngToScreenPointPage('user1')),
                );
              },
              child: Text('Show Buses'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
