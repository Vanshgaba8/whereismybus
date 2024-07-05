import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trialapp/loginsignup/loginpage.dart';
import 'package:trialapp/loginsignup/loginorregister.dart';
// import 'package:trialapp/screens/home_screen.dart';
// import 'package:trialapp/blacktint.dart';
import 'package:trialapp/blacktint.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User? user = snapshot.data;
            final String? email = user?.email;
            if (email != null) {
              return BlackTint();
            } else {
              return LoginOrRegisterPage();
            }
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
