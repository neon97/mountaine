import 'package:flutter/material.dart';
import 'package:projectflutter/constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //!controllers
  final _firstname = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();
  final _aboutYou = TextEditingController();

  //!keys
  final _formKey = GlobalKey<FormState>();

  //!datatypes

  Gender? _selectedgender;

  @override
  void initState() {
    _selectedgender = Gender.Male;
    super.initState();
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
              Image.asset(
                "image/logo.png",
              ),
//!name of the image

//! form validation
              Form(
                key: _formKey,
                child: Column(
                  children: [
//!firstname
                    TextFormField(
                      controller: _firstname,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == "" || value == null)
                          return "Field Left Empty !!";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "First Name",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
//!lastname
                    TextFormField(
                      controller: _lastName,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == "" || value == null)
                          return "Field Left Empty !!";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Last Name",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),

//!gender

                    DropdownButton<Gender>(
                        value: _selectedgender,
                        items: Gender.values
                            .map((genderType) => DropdownMenuItem<Gender>(
                                  child: Text(genderType.name),
                                  value: genderType,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedgender = value;
                          });
                        }),

//!email
                    TextFormField(
                      controller: _email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Field Left Empty !!";
                        } else {
                          if (value.contains(" ")) {
                            return "No spaces are allowed";
                          } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value) ==
                              false) {
                            return "Invalid Email";
                          } else if (value.length < 12) {
                            return "Min Length is 12";
                          } else {
                            return null;
                          }
                        }
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
//!mobile
                    Row(
                      children: [
                        //!mobile code
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            validator: (value) {
                              if (value == "" || value == null)
                                return "Field Left Empty !!";
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                                label: Text(
                              "Code",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        //!mobile no
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: _mobile,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            validator: (value) {
                              if (value == "" || value == null)
                                return "Field Left Empty !!";
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                                label: Text(
                              "Mobile No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),

//!about you
                    TextFormField(
                      maxLength: 250,
                      minLines: 2,
                      maxLines: 4,
                      controller: _aboutYou,
                      validator: (value) {
                        if (value == "" || value == null)
                          return "Field Left Empty !!";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                _aboutYou.clear();
                              },
                              icon: Icon(Icons.clear)),
                          label: Text(
                            "About you",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),

//!password
                    TextFormField(
                      controller: _password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == "" || value == null)
                          return "Field Left Empty !!";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
//!confirmpassword
                    TextFormField(
                      controller: _confirmPass,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == "" || value == null)
                          return "Field Left Empty !!";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Confirm Password",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

//! register button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_password.text == _confirmPass.text) {
                          print("we are good to go");
                        } else {
                          _password.clear();
                          _confirmPass.clear();
                          print("you need to check your password");
                        }
                      }
                    },
                    child: Text("Register")),
              ),
            ],
          )),
    );
  }
}
