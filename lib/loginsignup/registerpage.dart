import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trialapp/loginsignup/buttons/my_buttons.dart';
import 'package:trialapp/loginsignup/buttons/textfield.dart';
import 'package:trialapp/loginsignup/forgotpage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final cController = TextEditingController();
  final phoneno = TextEditingController();
  final naam = TextEditingController();

  void showerror(String s) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              s,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Future signuserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        cController.text.isEmpty ||
        naam.text.isEmpty ||
        phoneno.text.isEmpty) {
      Navigator.pop(context);
      showerror('Please fill all the fields');
    } else {
      try {
        if (passwordController.text == cController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          CollectionReference col =
              FirebaseFirestore.instance.collection('users');
          col.add({
            'Full Name': naam.text,
            'Contact No': phoneno.text,
            'Email': emailController.text,
          });
        }
        // else {
        //   showerror('Password and Confirm Password don\'t match');
        // }
        Navigator.pop(context);
        if (passwordController.text != cController.text) {
          showerror('Password and Confirm Password don\'t match');
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showerror(e.code);
      }
    }
  }

  void wrongEmailmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email or Password'),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cController.dispose();

    phoneno.dispose();

    naam.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: h / 100,
                ),
                Image.asset(
                  'assets/images/pbus.jpg',
                  height: h / 6,
                ),
                SizedBox(
                  height: h / 15,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Where is my Bus',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(
                  'Let\'s create an account for you!!!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: h / 30,
                ),

                mytextfield(
                  controller: naam,
                  hintText: 'Full Name',
                  obscureText: false,
                ),
                SizedBox(
                  height: h / 50,
                ),

                mytextfield(
                  controller: phoneno,
                  hintText: 'Contact No.',
                  obscureText: false,
                ),
                SizedBox(
                  height: h / 50,
                ),

                mytextfield(
                  controller: emailController,
                  hintText: 'Email ID',
                  obscureText: false,
                ),
                SizedBox(
                  height: h / 50,
                ),

                mytextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: h / 50,
                ),
                mytextfield(
                  controller: cController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: h / 50,
                ),
                mybutton(
                  onTap: signuserUp,
                  text: 'Sign Up',
                ),
                SizedBox(
                  height: h / 50,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text('Or continue with'),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: h / 50,
                // ),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.all(15),
                //     child: Image.asset(
                //       'assets/images/logo/google-logo.png',
                //       height: h / 25,
                //     ),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.white),
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.grey[200],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: h / 60,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    SizedBox(
                      width: w / 50,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h / 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
