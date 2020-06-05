import 'package:app/view/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Register.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 0, 235, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "DONTDIENOWANDRUN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 350.0,
                          child: TextFormField(
                            obscureText: false,
                            controller: userNameController,
                            textAlign: TextAlign.left,
                            validator: (value) => value.isEmpty
                                ? "Field must not be Empty"
                                : null,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: "Username",
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Username",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 350.0,
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            textAlign: TextAlign.left,
                            validator: (value) => value.isEmpty
                                ? "Field must not be Empty"
                                : null,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: "Password",
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          width: 350.0,
                          child: submitButton(
                            content: "Login",
                            onPressedFunction: () async {
                              if (this._formKey.currentState.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Text("No Account ? ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register())),
                            child: new Text(
                              "SIGNUP",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton submitButton({Function onPressedFunction, String content}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(0, 198,185,1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: onPressedFunction,
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
