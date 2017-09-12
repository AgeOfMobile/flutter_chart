import 'package:flutter/widgets.dart';
import 'package:flutter_chart/chart/chart.dart';
import 'package:flutter_chart/chart/line/line_chart_data.dart';
import 'package:flutter_chart/data/dataset.dart';
import 'package:flutter_chart/util/utils.dart';
import 'package:meta/meta.dart';

export 'line_chart_data.dart';

class LineChart extends Chart<LineChartData> {
  LineChart({ @required LineChartData data }): super(data: data);

  @override
  ChartPainter<LineChartData> createChartPainter(LineChartData data,
      Animation<double> animation) {
    return new LineChartPainter(data: data, animation: animation);
  }
}

class LineChartPainter extends ChartPainter<LineChartData> {
  LineChartPainter({
    @required LineChartData data,
    @required Animation<double> animation
  })
      : super(data: data, animation: animation);

  @override
  void paint(Canvas canvas, Size size) {
    _drawGridLines(canvas, size);

    for (int i = 0; i < this.data.dataSets.length; i++) {
      _drawDataSet(this.data.dataSets[i], this.data.lineColors[i],
          this.data.dotColors[i], canvas, size);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawGridLines(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = this.data.gridLineColor;

    final numberOfLines = 5;
    final delta = size.height / (numberOfLines - 1);
    for (int i = 0; i < numberOfLines; i++) {
      var y = size.height - i * delta;
      canvas.drawLine(new Offset(0.0, y), new Offset(size.width, y), paint);
    }
  }

  void _drawDataSet(DataSet dataSet, Color lineColor, Color dotColor,
      Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = lineColor
      ..strokeWidth = this.data.lineWidth
      ..style = PaintingStyle.stroke;

    final paint2 = new Paint()
      ..color = dotColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    // calculate points
    var x = 0.0;
    var delta = size.width / (dataSet.data.length - 1);
    var numPoints = (animation.value * dataSet.data.length).round();
    if (numPoints < 3) numPoints = 3;
    var data = dataSet.data.sublist(0, numPoints);
    var points = <Offset>[];
    for (final entry in data) {
      double y = size.height - entry.value;
      points.add(new Offset(x, y));
      x += delta;
    }

    Path path = new Path();
    path.moveTo(0.0, size.height - data.first.value);

    var index = 0;
    var tension = 0.3;
    var controlPoints = <Offset>[];
    while (index < numPoints - 2) {
      controlPoints.addAll(calculateControlPoints(
          points[index], points[index + 1], points[index + 2], tension));
      index++;
    }
    path.quadraticBezierTo(
        controlPoints[0].dx, controlPoints[0].dy, points[1].dx, points[1].dy);

    var pIndex = 1;
    while (pIndex < numPoints - 2) {
      var cpIndex1 = 2 * (pIndex - 1) + 1;
      var cpIndex2 = 2 * pIndex;
      path.cubicTo(
          controlPoints[cpIndex1].dx,
          controlPoints[cpIndex1].dy,
          controlPoints[cpIndex2].dx,
          controlPoints[cpIndex2].dy,
          points[pIndex + 1].dx,
          points[pIndex + 1].dy);

      pIndex++;
    }

    path.quadraticBezierTo(
        controlPoints[2 * (numPoints - 3) + 1].dx,
        controlPoints[2 * (numPoints - 3) + 1].dy,
        points[numPoints - 1].dx,
        points[numPoints - 1].dy);

    canvas.drawPath(path, paint);
    points.forEach((p) => canvas.drawCircle(p, 2.0, paint2));
  }
}
