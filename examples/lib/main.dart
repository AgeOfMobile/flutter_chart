import 'package:flutter/material.dart';
import 'package:flutter_chart/flutter_chart.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 200.0,
        child: new Chart(new LineChartPainter(
            new LineChartData(<DataSet>[
              new DataSet("Data Set 1", <Entry>[
                new Entry(100.0),
                new Entry(50.0),
                new Entry(90.0)
              ])
            ], <String>[])
          )
        )
    );
  }
}
