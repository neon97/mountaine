import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectflutter/api.dart';
import 'package:projectflutter/constant.dart';
import 'package:projectflutter/controller/emailSignin.dart';
import 'package:projectflutter/models/LoginModel.dart';
import 'package:projectflutter/networkHelper.dart';
import 'package:projectflutter/view/homescreen.dart';
import 'package:projectflutter/view/registerPage.dart';
import 'package:projectflutter/widgets/loader.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //! comtrollers
  final _usernameCntrl = TextEditingController();
  final _passCntrl = TextEditingController();
  bool _visibility = true;

  //!datatypes
  bool _mobileEmail = true;

  //!key
  final _formkey = GlobalKey<FormState>(); //! this is the random key for me

  //!functions
  _getLogin() async {
    var response = await hitApi(loginApi(_usernameCntrl.text, _passCntrl.text));
    LoginModel loginModel = LoginModel.fromJson(response);
    return loginModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.deepOrange,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
//!logo
            Image.asset("image/logo.png"),

//!appname
            Text(
              "Mountainer's",
              style: GoogleFonts.balooBhaijaan(
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),

//!switch button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mobile No",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                CupertinoSwitch(
                    value: _mobileEmail,
                    onChanged: (value) {
                      setState(() {
                        _mobileEmail = value;
                        _usernameCntrl.clear();
                        _passCntrl.clear();
                      });
                    }),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            Form(
                key: _formkey,
                child: Column(
                  children: [
//!mobile no & email
                    TextFormField(
                      controller: _usernameCntrl,
                      keyboardType: !_mobileEmail
                          ? TextInputType.number
                          : TextInputType.emailAddress,
                      maxLength: !_mobileEmail ? 10 : null,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Field Left Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          label: Text(
                        !_mobileEmail ? "Mobile No" : "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

//! password
                    TextFormField(
                      controller: _passCntrl,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _visibility,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Field Left Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _visibility = !_visibility;
                                });
                              },
                              icon: Icon(_visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          label: Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),

            SizedBox(
              height: 20,
            ),

//!login button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () => _loginValidation(), child: Text("Login")),
            ),

//! recover password
            TextButton(
                onPressed: () {},
                child: Text(
                  "Recover Password",
                  style: TextStyle(),
                )),

//!register button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Text("Register")),
            ),
          ],
        ),
      ),
    );
  }

  apiValiadtion() async {
    loginGlobalModel = await _getLogin();
    //!removing the loader as we have got the reponse from api
    Navigator.pop(context);
    if (loginGlobalModel!.status! == "true") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Homescreenpage()));
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Alert !!"),
                content: Text(loginGlobalModel!.messageinfo!),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              ));
    }
  }

  firebaseValidation() async {
    AuthenticationService _authService = AuthenticationService(auth);
    var response =
        await _authService.signIn(_usernameCntrl.text, _passCntrl.text);
    Navigator.pop(context);

    if (response == "Signed In") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Homescreenpage()));
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Alert !!"),
                content: Text(response),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              ));
    }
  }

  _loginValidation() async {
    if (_formkey.currentState!.validate()) {
      //! loader i have show here
      loader(context);
      if (!_mobileEmail)
        apiValiadtion();
      else
        firebaseValidation();
    }
  }
}
