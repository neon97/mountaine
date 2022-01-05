import 'package:flutter/material.dart';
import 'package:projectflutter/controller/emailSignin.dart';
import 'package:projectflutter/view/homescreen.dart';
import 'package:projectflutter/view/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //! backgroung service
    authServiceEmailPass.authStateChnages.listen((event) {
      print(" ******* $event ********");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var response = authServiceEmailPass.getUser();
    if (response == null || !response.emailVerified) {
      return SplashScreen();
    } else {
      return Homescreenpage();
    }
  }
}

//!global values
AuthenticationService authServiceEmailPass = AuthenticationService(auth);
