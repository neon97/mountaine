import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectflutter/view/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //?createState ==> 1st phase

//?initState  => 2nd phase (optinal)
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  //!function
  _startTimer() {
    //! background function timer
    Timer(Duration(seconds: 5), _navigate);
  }

  _navigate() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //!reload starts form here // refreshing the satte

  //?build => 3nd phase build
  //? it will render the widgets to the user app infornt of user eye
  @override
  Widget build(BuildContext context) {
    //! build method
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //!device height & width
        //!MediaQuerry

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("image/logo.png"),
            Text(
              "Mountainer's",
              style: GoogleFonts.balooBhaijaan(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "It's time to climb mountain's this winter",
              style: TextStyle(
                  fontFamily: GoogleFonts.balooBhaijaan().fontFamily,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "ver 1.0.0",
              style: TextStyle(
                fontFamily: GoogleFonts.balooBhaijaan().fontFamily,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
