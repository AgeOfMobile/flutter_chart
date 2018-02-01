import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chart/axis/axes.dart' as chart;
import 'package:flutter_chart/chart/line/line_chart.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:flutter_chart/data/entry.dart';
import 'package:flutter_chart/scale/linear_scale.dart';
import 'package:flutter_chart/scale/scales.dart';

class LineChartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random random = new Random();

    final yScale1 = new LinearScale(domainMin: 0.0, domainMax: 120.0);
    final yScale2 = new LinearScale(domainMin: 0.0, domainMax: 100.0);
    final xScale = new CategoryScale(name: "x",
      values: <String>["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]);
    final xAxis = new chart.CategoryAxis(scale: xScale);
    final yAxis = new chart.LinearAxis(scale: yScale1, tickCount: 12,
      gridLineColor: const Color(0xFFAAAAAA));

    return new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Center(
            child: new Text("Line Chart Demo",
              style: Theme.of(context).accentTextTheme.headline.copyWith(color: Colors.black),
            ),
          ),
        ),
        new Container(
          width: 350.0,
          height: 220.0,
          padding: const EdgeInsets.all(16.0),
          child: new LineChart(
            data: new LineChartData(
              dataSets: <DataSet>[
                new DataSet(
                  name: "dataSet1",
                  label: "Data Set 1",
                  data: new List<Entry>.generate(
                    2, (i) => new Entry(i * 10.0)),
                ),
                new DataSet(
                  name: "dataSet2",
                  label: "Data Set 2",
                  data: new List<Entry>.generate(
                    12, (i) => new Entry(random.nextInt(20) * 1.0)),
                ),
              ],
              colors: <Color>[
                Colors.blueAccent,
                Colors.redAccent,
              ],
              dotColors: <Color>[
                Colors.deepPurpleAccent,
                Colors.deepPurpleAccent,
              ],
              lineWidth: 2.0,
              xScales: {
                "dataSet1": xScale,
                "dataSet2": xScale,
              },
              yScales: {
                "dataSet1": yScale1,
                "dataSet2": yScale2,
              },
              axes: <chart.Axis>[
                xAxis,
                yAxis
              ]
            ),
          ),
        ),
      ],
    );
  }
}