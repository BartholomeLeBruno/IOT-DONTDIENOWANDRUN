import 'dart:async';

import 'package:app/view/Transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectToApp extends StatefulWidget {
  @override
  State<ConnectToApp> createState() => _ConnectToAppState();
}

class _ConnectToAppState extends State<ConnectToApp> {
  double _progress = 0;
  List<bool> isSelected = [false, true];
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 0, 235, 1),
      appBar: AppBar(
        title: Text(
          "Connect to peripheral",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Turn bluetooth",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ToggleButtons(
                fillColor: Colors.blue,
                onPressed: (int index) {
                  setState(
                    () {
                      isSelected[0] = !isSelected[0];
                      isSelected[1] = !isSelected[1];
                      _progress = 0;
                      isSelected[0] == true
                          ? isVisible = true
                          : isVisible = false;
                      startTimer();
                    },
                  );
                },
                children: <Widget>[
                  Text(
                    "ON",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "OFF",
                    style: TextStyle(color: Colors.white),
                  )
                ],
                isSelected: isSelected,
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Visibility(
            visible: isVisible,
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Transfer())),
              title: Text(
                "DONTDIENOWANDRUN",
                style: TextStyle(color: Colors.white),
              ),
              trailing: _progress < 1 ? CircularProgressIndicator(
                value: _progress,
              ) : Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == 1) {
            timer.cancel();
          } else {
            _progress += 0.2;
          }
        },
      ),
    );
  }
}
