import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter_chart/axis/axis.dart';
import 'package:flutter_chart/chart/chart.dart';
import 'package:flutter_chart/data/chart_data.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:flutter_chart/data/entry.dart';
import 'package:flutter_chart/scale/scale.dart';
import 'package:meta/meta.dart';

class DonutChartData extends ChartData {
  DonutChartData({
    @required List<DataSet> dataSets,
    @required Map<String, Scale> scales,
    List<Axis> axes,
    this.colors,
    this.arcWidth: 50.0,
    this.arcWidthStep: 5.0,
  }):
    assert(dataSets != null && dataSets.length == 1),
    assert(colors == null || (colors.length >= dataSets[0].data.length)),
    super(dataSets: dataSets, scales: scales, axes: axes);

  final List<Color> colors;
  final double arcWidth;
  final double arcWidthStep;
}

class DonutChart extends Chart<DonutChartData> {
  DonutChart({ @required DonutChartData data }): super(data: data);

  @override
  ChartPainter<DonutChartData> createChartPainter(
      DonutChartData data, Animation<double> animation) {
    return new _DonutChartPainter(data: data, animation: animation);
  }
}

class _DonutChartPainter extends ChartPainter<DonutChartData> {
  static const startAtAngle = -0.5 * PI;

  Color _darkerColor(Color color, int amount) {
    int col = color.value;
    return new Color(
        ((col & 0x0000FF) + amount) |
        ((((col >> 8) & 0x00FF) + amount) << 8) |
        (((col >> 16) + amount) << 16)
    );
  }

  _DonutChartPainter(
      {@required DonutChartData data, @required Animation<double> animation})
      : super(data: data, animation: animation);

  @override
  void paintChart(Canvas canvas, Size size) {
    if (this.data.dataSets[0].data.isEmpty) return;

    Paint paint = new Paint()
      ..style = PaintingStyle.fill;

    var startAngle = startAtAngle;
    List<Entry> entries = this.data.dataSets[0].data;
    double sum = entries.reduce((e1, e2) => new Entry(e1.value + e2.value)).value;
    List<double> values = entries.map((entry) => entry.value / sum).toList();

    double radius = min(size.width, size.height) - this.data.arcWidth;

    var index = 0;
    values.forEach((value) {
      double sweepAngle = value * 2 * PI;
      paint.color = this.data.colors[index];
      paint.shader = new Gradient.linear(new Offset(0.0, 0.0), new Offset(size.width, size.height),
          <Color>[
          _darkerColor(this.data.colors[index], -50),
          this.data.colors[index],
        ]
      );

      Rect rect = new Rect.fromLTWH(
          (size.width - radius) / 2,
          (size.height - radius) / 2,
          radius,
          radius);

      double start = startAtAngle + animation.value * (startAngle - startAtAngle);
      double sweep = animation.value * sweepAngle;

      Path path = new Path();
      _arcTo(path, rect, start, sweep, true);

      double outerRadius = radius +
        (this.data.arcWidth - index * this.data.arcWidthStep);
      rect = new Rect.fromLTWH(
        (size.width - outerRadius) / 2,
        (size.height - outerRadius) / 2,
        outerRadius,
        outerRadius);
      _arcTo(path, rect, start + sweep, -sweep, false);

      // close the path to make a donut sector
      path.close();

      canvas.drawPath(path, paint);

      startAngle += sweepAngle;
      index += 1;
    });
  }

  @override
  bool shouldRepaint(rendering.CustomPainter oldDelegate) {
    return true;
  }

  // Skia (Flutter's drawing library) doesn't support sweepAngle >= 2 * PI so we need to split into 2 arcs
  void _arcTo(Path path, Rect rect, double startAngle, double sweepAngle, bool forceMoveTo) {
    if (sweepAngle == 2 * PI || sweepAngle == -2 * PI) {
      path.arcTo(rect, startAngle, sweepAngle / 2, true);
      path.arcTo(rect, startAngle + sweepAngle / 2, sweepAngle / 2, forceMoveTo);
    } else {
      path.arcTo(rect, startAngle, sweepAngle, forceMoveTo);
    }
  }
}
