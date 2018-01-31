import 'package:flutter/material.dart';
import 'package:flutter_chart/flutter_chart.dart';

class DonutChartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Center(
            child: new Text("Donut Chart Demo",
              style: Theme.of(context).accentTextTheme.headline.copyWith(color: Colors.black),
            ),
          ),
        ),
        new Expanded(
          child: new Container(
            width: 350.0,
            height: 200.0,
            child: new DonutChart(
              data: new DonutChartData(
                dataSets: <DataSet>[
                  new DataSet(
                    name: "dataSet1",
                    label: "Data Set 1",
                    data: <Entry>[
                      new Entry(25.0),
                      new Entry(12.5),
                      new Entry(22.5),
                      new Entry(40.0),
                    ],
                  ),
                ],
                scales: {},
                colors: <Color>[
                  const Color(0xFFFF8540),
                  const Color(0xFFB269EE),
                  const Color(0xFF4AD8CF),
                  const Color(0xFFBDBCC8),
                ],
                arcWidth: 80.0,
                arcWidthStep: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}