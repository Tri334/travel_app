import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/screens/landing_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static String routeName = '/profilepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed(LandingPage.routeName);
          },
          child: const Text('Sign Out')),
    ));
  }
}
