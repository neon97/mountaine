import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectflutter/api.dart';
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

            Form(
                key: _formkey,
                child: Column(
                  children: [
//!mobile no
                    TextFormField(
                      controller: _usernameCntrl,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Field Left Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixText: "+91 - ",
                          label: Text(
                            "Mobile No",
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

  _loginValidation() async {
    if (_formkey.currentState!.validate()) {
      //! loader i have show here
      loader(context);
      LoginModel loginModel = await _getLogin();

      //!removing the loader as we have got the reponse from api
      Navigator.pop(context);
      if (loginModel.status! == "true") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Homescreenpage(
                  loginModel: loginModel,
                )));
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Alert !!"),
                  content: Text(loginModel.messageinfo!),
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
  }
}
