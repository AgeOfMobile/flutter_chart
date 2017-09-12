import 'dart:ui';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter_chart/chart/chart.dart';
import 'package:flutter_chart/data/chartdata.dart';
import 'package:flutter_chart/data/dataset.dart';
import 'package:flutter_chart/data/entry.dart';
import 'package:meta/meta.dart';

class DonutChartData extends ChartData {
  DonutChartData({
    @required List<DataSet> dataSets,
    this.colors
  }):
    assert(dataSets != null && dataSets.length == 1),
    assert(colors == null || (colors.length == dataSets[0].data.length)),
    super(dataSets: dataSets);

  final List<Color> colors;
}

class DonutChart extends Chart<DonutChartData> {
  DonutChart({ @required DonutChartData data }): super(data: data);

  @override
  ChartPainter<DonutChartData> createChartPainter(
      DonutChartData data, Animation<double> animation) {
    return new DonutChartPainter(data: data, animation: animation);
  }
}

class DonutChartPainter extends ChartPainter<DonutChartData> {
  DonutChartPainter(
      {@required DonutChartData data, @required Animation<double> animation})
      : super(data: data, animation: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = this.data.backgroundColor
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    var startAngle = 1.5 * PI;
    List<Entry> entries = this.data.dataSets[0].data;
    entries.sort((e1, e2) => e2.value.compareTo(e1.value));
    double sum = entries.reduce((e1, e2) => new Entry(e1.value + e2.value)).value;
    List<double> values = entries.map((entry) => entry.value / sum).toList();
    var index = 0;

    double radius = min(size.width, size.height) - paint.strokeWidth;
    Rect rect = new Rect.fromLTWH(
        (size.width - radius) / 2,
        (size.height - radius) / 2,
        radius,
        radius);

    values.forEach((value) {
      double sweepAngle = value * 2 * PI;
      paint.color = this.data.colors[index];
      paint.strokeWidth = paint.strokeWidth - 5;
//      painting.HSVColor color = new painting.HSVColor.fromColor(this.data.colors[index]);
//      paint.shader = new Gradient.linear(new Offset(0.0, 0.0), new Offset(0.5, 0.5), <Color>[
//        this.data.colors[index],
//        const Color(0xFFFFFFFF)
//      ]);
      canvas.drawArc(rect, startAngle, animation.value * sweepAngle, false, paint);
      startAngle += sweepAngle;
      index += 1;
    });
  }

  @override
  bool shouldRepaint(rendering.CustomPainter oldDelegate) {
    return true;
  }
}
