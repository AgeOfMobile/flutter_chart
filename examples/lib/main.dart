import 'package:examples/donut_chart_demo.dart';
import 'package:examples/line_chart_demo.dart';
import 'package:examples/pie_chart_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Chart Demo"),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(height: 300.0, child: new LineChartDemo()),
              new Container(height: 300.0, child: new DonutChartDemo()),
              new Container(height: 300.0, child: new PieChartDemo()),
            ],
          ),
        ),
      ),
    );
  }
}
