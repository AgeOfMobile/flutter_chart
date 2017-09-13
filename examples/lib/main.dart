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
                const Color(0xFFFF22FF),
                const Color(0xFF00FFFF),
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
    );
  }
}
