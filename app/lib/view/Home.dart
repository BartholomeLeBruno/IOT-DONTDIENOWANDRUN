import 'package:app/model/fcmWork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Home extends StatefulWidget {
  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 0, 235, 1),
      appBar: AppBar(
        title: Text(
          "REPORTING",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "FCM Current Week",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 350,
              child: charts.BarChart(
                _createBarFcmListOfPoint(),
                animate: true,
              ),
            ),
            Text(
              "FCM Current Week",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 350,
              child: charts.LineChart(
                _createLineFcmListOfPoint(),
                animate: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<charts.Series<FcmWork, String>> _createBarFcmListOfPoint() {
    final data = [
      new FcmWork.byDayAsDay('Monday', 100),
      new FcmWork.byDayAsDay('Tueday', 210),
      new FcmWork.byDayAsDay('Wednesday', 102),
      new FcmWork.byDayAsDay('Thursday', 108),
    ];

    return [
      new charts.Series<FcmWork, String>(
        id: 'FCM current week',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (FcmWork fcm, _) => fcm.dayOfWeek,
        measureFn: (FcmWork fcm, _) => fcm.fcm,
        data: data,
      )
    ];
  }

  List<charts.Series<FcmWork, int>> _createLineFcmListOfPoint() {
    final data = [
      new FcmWork.byDayAsInt(0, 100),
      new FcmWork.byDayAsInt(1, 210),
      new FcmWork.byDayAsInt(2, 102),
      new FcmWork.byDayAsInt(3, 108),
    ];

    return [
      new charts.Series<FcmWork, int>(
        id: 'FCM current week',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (FcmWork fcm, _) => fcm.day,
        measureFn: (FcmWork fcm, _) => fcm.fcm,
        data: data,
      )
    ];
  }
}
