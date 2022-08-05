import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/models/image.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  static String routeName = '/landingpage';

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
                  const Color.fromRGBO(17, 17, 17, 0.1)
                ])),
          ),
          Positioned(
            bottom: 40.sp,
            right: 22.sp,
            left: 22.sp,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Lets explore \nthe world together',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'We are your best travel agency',
                    style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  InkWell(
                    radius: 16,
                    splashColor: const Color.fromARGB(193, 240, 47, 76),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFA4560),
                          borderRadius: BorderRadius.circular(16)),
                      height: 48.sp,
                      width: 320.sp,
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      );
    });
  }
}

class LandingImageCover extends StatelessWidget {
  const LandingImageCover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        images[0].image,
        fit: BoxFit.cover,
      ),
    );
  }
}
