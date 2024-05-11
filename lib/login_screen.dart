import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:urban_green_space_enhancement/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  final UserCredential authResult = await _auth.signInWithCredential(credential);

  // You can access whether the user is a new or returning user via
  // authResult.additionalUserInfo.isNewUser

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );




  return authResult;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool signup=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage("assets/background3.png"),
                    fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Container(
                width: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 5,
                  color: Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          scale: 5,
                        ),
                        Text(
                          signup?"Sign Up":"Login",
                          style:
                              TextStyle(fontSize: 30, fontFamily: "MadimiOne"),
                        ),
                        TextFieldLoginScreen(
                          userNameController: userNameController,
                          label: 'Username',
                          hint: 'Enter username ',
                          obscureText: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldLoginScreen(
                          userNameController: passwordController,
                          label: 'Password',
                          hint: 'Enter Password ',
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                       signup? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.8)),
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: userNameController.text,
                                password: passwordController.text,
                              );
                              log(credential.toString());
                              if (credential.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeScreen();
                                    },
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              } else if (e.code == 'user-not-found') {
                                Fluttertoast.showToast(
                                    msg:
                                        "User not found!! Please Create User!!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              print(e.code);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontFamily: "MadimiOne"),
                          ),
                        ): ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.8)),
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: userNameController.text,
                                password: passwordController.text,
                              );
                              log(credential.toString());
                              if (credential.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeScreen();
                                    },
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              } else if (e.code == 'user-not-found') {
                                Fluttertoast.showToast(
                                    msg:
                                        "User not found!! Please Create User!!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              print(e.code);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontFamily: "MadimiOne"),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                signInWithGoogle(context);
                              },
                              child: Image.asset(
                                "assets/googlelogo.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Image.asset(
                              "assets/facebook.png",
                              height: 50,
                              width: 50,
                            ),
                            Image.asset(
                              "assets/X-Logo.png",
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        Divider(),
                        signup? TextButton(
                            onPressed: () {
                              setState(() {
                                signup=false;
                              });
                            },
                            child: Text(
                              "Already have a account? Login now!!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MadimiOne",
                                  fontSize: 16),
                            )): TextButton(
                            onPressed: () {
                              setState(() {
                                signup=true;
                              });
                            },
                            child: Text(
                              "Don't have a account? Create now!!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MadimiOne",
                                  fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldLoginScreen extends StatelessWidget {
  const TextFieldLoginScreen({
    super.key,
    required this.userNameController,
    required this.label,
    required this.hint,
    required this.obscureText,
  });

  final String label;
  final bool obscureText;
  final String hint;
  final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        controller: userNameController,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          label: Text(
            label,
            style: TextStyle(fontFamily: "MadimiOne"),
          ),
          hintText: hint,
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
