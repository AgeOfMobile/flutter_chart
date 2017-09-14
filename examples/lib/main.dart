import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chart/flutter_chart.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random random = new Random();

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Chart Demo"),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Center(child: new Text("Line Chart")),
            new Container(
              width: 350.0,
              height: 220.0,
              padding: const EdgeInsets.all(16.0),
              child: new LineChart(
                data: new LineChartData(
                  dataSets: <DataSet>[
                    new DataSet(
                      label: "Data Set 1",
                      data: new List<Entry>.generate(
                          12, (i) => new Entry(random.nextInt(20) * 10.0)),
                    ),
                    new DataSet(
                      label: "Data Set 2",
                      data: new List<Entry>.generate(
                          12, (i) => new Entry(random.nextInt(20) * 10.0)),
                    ),
                  ],
                  lineColors: <Color>[
                    Colors.blueAccent,
                    Colors.redAccent,
                  ],
                  dotColors: <Color>[
                    Colors.deepPurpleAccent,
                    Colors.deepPurpleAccent,
                  ],
                  lineWidth: 2.0,
                ),
              ),
            ),
            new Center(child: new Text("Donut Chart")),
            new Center(
              child: new Container(
                width: 350.0,
                height: 200.0,
                child: new DonutChart(
                  data: new DonutChartData(
                    dataSets: <DataSet>[
                      new DataSet(
                        label: "Data Set 1",
                        data: <Entry>[
                          new Entry(25.0),
                          new Entry(12.5),
                          new Entry(12.5),
                          new Entry(50.0)
                        ],
                      ),
                    ],
                    colors: <Color>[
                      const Color(0xFFFF8540),
                      const Color(0xFFB269EE),
                      const Color(0xFF4AD8CF),
                      const Color(0xFFBDBCC8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
