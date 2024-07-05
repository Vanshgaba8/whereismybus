import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trialapp/passengersearch.dart';
import 'conductor_side.dart';
// import 'package:mybusapp/components/waitingmode.dart';
// import 'package:mybusapp/components/conductor.dart';
// import 'package:mybusapp/components/passengersearch.dart';

class BlackTint extends StatefulWidget {
  const BlackTint({Key? key}) : super(key: key);

  @override
  State<BlackTint> createState() => _BlackTintState();
}

// Future<bool?> _onBackPressed() async {
//   var context;
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Do you want to exit?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//                 SystemNavigator.pop();
//               },
//             ),
//           ],
//         );
//       });
// }

class _BlackTintState extends State<BlackTint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: bahar, icon: const Icon(Icons.logout))],
      ),
      backgroundColor: Colors.grey.shade300,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConductorSide(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.deepPurple,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Conductor Mode',
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: 'Welcome to HRTC');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.deepPurple,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'User/Passenger Mode',
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  void bahar() {
    FirebaseAuth.instance.signOut();
  }
}
