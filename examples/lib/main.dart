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

    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          width: 350.0,
          height: 200.0,
          child: new LineChart(
            data: new LineChartData(
              dataSets: <DataSet>[
                new DataSet(
                  label: "Data Set 1",
                  data: new List<Entry>.generate(
                      50, (i) => new Entry(random.nextInt(20) * 10.0)),
                ),
                new DataSet(
                  label: "Data Set 2",
                  data: new List<Entry>.generate(
                      30, (i) => new Entry(random.nextInt(20) * 10.0)),
                ),
              ],
              lineColors: <Color>[
                new Color(0xFFFF22FF),
                new Color(0xFF0000FF),
              ],
            ),
          ),
        ),
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
                      new Entry(10.0),
                      new Entry(20.0),
                      new Entry(40.0),
                      new Entry(30.0)
                    ],
                  ),
                ],
                colors: <Color>[
                  new Color(0xFFFF0000),
                  new Color(0xFF00FF00),
                  new Color(0xFF0000FF),
                  new Color(0xFFFFFFFF),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
