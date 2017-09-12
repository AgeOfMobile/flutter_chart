import 'package:flutter/widgets.dart';
import 'package:flutter_chart/chart/chart.dart';

import 'package:flutter_chart/data/chartdata.dart';
import 'package:flutter_chart/data/dataset.dart';

class LineChartData extends ChartData {
  LineChartData(List<DataSet> dataSets, List<String> labels,
  {
    this.lineColors,
    this.lineWidth,
    this.dotColors,
    this.gridLineColor: const Color(0xFF666666),
  }): super(dataSets, labels);

  List<Color> lineColors;
  double lineWidth;
  List<Color> dotColors;
  Color gridLineColor;
}

class LineChartPainter extends ChartPainter<LineChartData> {
  LineChartPainter(LineChartData data) : super(data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = new Color(0xFFFF0000);
    canvas.drawCircle(new Offset(size.width / 2, size.height / 2), 50.0, paint);
    _drawGridLines(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawGridLines(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = this.data.gridLineColor;

    final numberOfLines = 5;
    final delta = size.width / (numberOfLines - 1);
    for (int i = 0; i < numberOfLines; i++) {
      var y = size.height - i * delta;
      canvas.drawLine(new Offset(0.0, y), new Offset(size.width, y), paint);
    }
  }
}
