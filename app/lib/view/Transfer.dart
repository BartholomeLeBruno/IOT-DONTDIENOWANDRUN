import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Transfer extends StatefulWidget {
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 0, 235, 1),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Data transfer in progress",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 3,
              child: Image.asset("assets/smartphone.png"),
            ),
            Flexible(
              flex: 3,
              child: RotatedBox(
                quarterTurns: 5,
                child: LinearProgressIndicator(),
              ),
            ),
            Flexible(
              flex: 2,
              child: Image.asset("assets/bracelet.png"),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    new Timer.periodic(Duration(seconds: 5), (Timer timer) {
      timer.cancel();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    });
  }
}
