import 'package:app/view/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 0, 235, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REGISTER",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
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
                        validator: (value) =>
                            value.isEmpty ? "Field must not be Empty" : null,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: "Username",
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        textAlign: TextAlign.left,
                        validator: (value) =>
                            value.isEmpty ? "Field must not be Empty" : null,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: TextFormField(
                        obscureText: false,
                        controller: birthDateController,
                        textAlign: TextAlign.left,
                        onTap: () => _selectDate(),
                        validator: (value) =>
                            value.isEmpty ? "Field must not be Empty" : null,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: "BirthDate",
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "BirthDate",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350,
                      child: submitButton(
                        content: "SUBMIT",
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1996),
        lastDate: new DateTime(DateTime.now().year + 2));
    if (picked != null)
      setState(
          () => birthDateController.text = DateFormat.yMMMd().format(picked));
  }

  RaisedButton submitButton({Function onPressedFunction, String content}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(0, 198, 185, 1),
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
