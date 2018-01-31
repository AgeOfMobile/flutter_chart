import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_chart/chart/chart.dart';
import 'package:flutter_chart/chart/line/line_chart_data.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:flutter_chart/scale/category_scale.dart';
import 'package:flutter_chart/scale/linear_scale.dart';
import 'package:flutter_chart/scale/scale.dart';
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
  }): super(data: data, animation: animation);

  @override
  void paint(Canvas canvas, Size size) {

    this.data.axes.forEach((axis) => axis.draw(canvas, size));

    for (int i = 0; i < this.data.dataSets.length; i++) {
      final dataSet = this.data.dataSets[i];

      var xScale = _getScale(this.data.xScales, dataSet.name);
      if (xScale == null) {
        //xScale = new LinearScale(domainMin: 0.0, domainMax: size.width);
        xScale = new CategoryScale(
          name: "xScale",
          values: new List.generate(dataSet.data.length, (index) => "$index"),
          min: "",
          max: "",
        );
      }

      var yScale = _getScale(this.data.scales, dataSet.name);
      if (yScale == null) {
        final values = dataSet.data.map((e) => e.value);
        final minValue = values.reduce((min, value) => math.min(min, value));
        final maxValue = values.reduce((max, value) => math.max(max, value));
        // default scale will render maximum value at 80% of scale
        yScale = new LinearScale(domainMin: minValue, domainMax: maxValue * 1.25);
      }

      _drawDataSet(this.data.dataSets[i], this.data.colors[i],
          this.data.dotColors[i], this.data.tension, canvas, size, xScale, yScale);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate == null ||
      (oldDelegate as LineChartPainter).animation.value != this.animation.value;
  }

  Scale _getScale(Map<String, Scale> scales, String name) {
    return (scales != null) ? scales[name] : null;
  }

  void _drawDataSet(DataSet dataSet, Color lineColor, Color dotColor,
    double tension, Canvas canvas, Size size, Scale xScale, Scale yScale) {
    final linePaint = new Paint()
      ..color = lineColor
      ..strokeWidth = this.data.lineWidth
      ..style = PaintingStyle.stroke;

    final dotPaint = new Paint()
      ..color = dotColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    // calculate points
    var numPoints = (animation.value * dataSet.data.length).round();
    if (numPoints < 3) numPoints = 3;
    var data = dataSet.data.sublist(0, numPoints);
    var points = <Offset>[];
    var index = 0;
    for (final entry in data) {
      double pX = xScale.scale(null, index, size.width);
      double pY = size.height - yScale.scale(entry.value, index, size.height);
      points.add(new Offset(pX, pY));
      index += 1;
    }

    Path path = new Path();
    path.moveTo(points[0].dx, points[0].dy);

    index = 0;
    var controlPoints = <Offset>[];
    while (index < numPoints - 2) {
      controlPoints.addAll(calculateControlPoints(
          points[index], points[index + 1], points[index + 2], tension));
      index++;
    }

    // first segment
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

    // last segment
    path.quadraticBezierTo(
        controlPoints[2 * (numPoints - 3) + 1].dx,
        controlPoints[2 * (numPoints - 3) + 1].dy,
        points[numPoints - 1].dx,
        points[numPoints - 1].dy);

    canvas.drawPath(path, linePaint);
    points.forEach((p) => canvas.drawCircle(p, 2.0, dotPaint));
  }
}
