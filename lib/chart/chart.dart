import 'package:flutter/widgets.dart';
import 'package:flutter_chart/data/chartdata.dart';

class Chart extends StatefulWidget {
  Chart(this.chartPainter);

  final ChartPainter chartPainter;

  @override
  State<StatefulWidget> createState() {
    return new _ChartState();
  }
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      size: new Size(350.0, 150.0),
      painter: this.widget.chartPainter,
    );
  }
}

abstract class ChartPainter<T extends ChartData> extends CustomPainter {
  ChartPainter(this.data);
  T data;
}
