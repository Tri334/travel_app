import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/Screens/landing_page.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:travel_app/screens/selector_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String routeName = '/loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool get mounted => super.mounted;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Stack(children: [
          const LandingImageCover(),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Colors.black.withOpacity(0.7),
                  const Color.fromRGBO(17, 17, 17, 0.5)
                ])),
          ),
          Positioned(
            bottom: 30.sp,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: styleColor.subjudul),
                              hintStyle: TextStyle(color: styleColor.subjudul),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xffFA4560),
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'name@email.com',
                              labelText: 'Email'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: styleColor.subjudul),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xffFA4560),
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: '*****',
                              labelText: 'Password'),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                          color: styleColor.style,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 75.sp,
                      height: 35.sp,
                      decoration: BoxDecoration(
                          color: styleColor.style,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: styleColor.style, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.sp,
                      height: 2,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        'OR',
                        style: GoogleFonts.poppins(color: Colors.white70),
                      ),
                    ),
                    Container(
                      width: 100.sp,
                      height: 2,
                      color: Colors.white70,
                    ),
                  ],
                ),
                Text(
                  'Sign In with Social Network',
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
                SignInButton(Buttons.Google, onPressed: () async {
                  try {
                    GoogleSignInAccount? account =
                        await GoogleSignIn().signIn();
                    if (account != null) {
                      GoogleSignInAuthentication auth =
                          await account.authentication;
                      OAuthCredential credential =
                          GoogleAuthProvider.credential(
                              accessToken: auth.accessToken,
                              idToken: auth.idToken);
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Future.delayed(const Duration(seconds: 2));
                      if (!mounted) {}
                      Navigator.of(context)
                          .pushReplacementNamed(PageSelector.routeName);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(child: Text('You are offline'))));
                  }
                })
              ],
            ),
          )
        ]),
      );
    });
  }
}
