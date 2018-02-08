import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chart/flutter_chart.dart';
import 'package:flutter_chart/axis/axis.dart' as chart;

class Legend {
  final String label;
  final String icon;
  Legend({ this.label, this.icon });
}

class DonutChartAxis extends chart.Axis {
  final List<Legend> legends;
  final DataSet dataSet;
  final double outerRadius;
  final double innerRadius;
  final double width;
  final double height;
  final double padding;

  DonutChartAxis({
    this.legends,
    this.dataSet,
    this.width,
    this.height,
    this.padding,
    this.outerRadius,
    this.innerRadius}): super(position: chart.AxisPosition.undefined);

  @override
  void draw(Canvas canvas, Size size) {
    final double sum = dataSet.data.fold(0.0, (value, e) => value + e.value);
//    final int total = dataSet.data.length;
    final Iterable<double> percentages = dataSet.data.map((e) => e.value / sum);
    final Offset origin = new Offset(size.width / 2, size.height / 2);
    Paint paint = new Paint()
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..color = new Color(0xFF999999);

    int index = 0;
    percentages.fold(-0.5 * PI, (double startAngle, double value) {
      final double sweepAngle = 2 * PI * value;
      final legendAngle = startAngle + sweepAngle / 2.0;
      final Offset anchor = new Offset(
          this.outerRadius * cos(legendAngle) + origin.dx,
          this.outerRadius * sin(legendAngle) + origin.dy);

      final startAnchorX = this.innerRadius * cos(legendAngle) + origin.dx;
      final startAnchorY = this.innerRadius * sin(legendAngle) + origin.dy;

      canvas.drawLine(new Offset(startAnchorX, startAnchorY), anchor, paint);

      final Rect rect = _fitRect(_getLegendRect(origin.dx, origin.dy, anchor.dx, anchor.dy), size);
      final bool reverse = anchor.dx < origin.dx;
      final Offset middle = new Offset(anchor.dx + (reverse ? -padding : padding),
                                       anchor.dy);
//      canvas.drawRect(rect, paint);
      canvas.drawLine(anchor, middle, paint);

      drawLegend(canvas, legends[index], value, rect, reverse);

      index += 1;
      return startAngle + sweepAngle;
    });
  }

  void drawLegend(Canvas canvas, Legend legend, double value, Rect rect, bool reverse) {
    const TextStyle normalStyle =
      const TextStyle(color: const Color(0xFF000000), fontWeight: FontWeight.normal);
    const TextStyle boldStyle =
    const TextStyle(color: const Color(0xFF000000), fontWeight: FontWeight.bold);

    TextPainter textPainter = new TextPainter(
      text: new TextSpan(style: boldStyle, text: "${value * 100} %",
      children: <TextSpan>[new TextSpan(text: "\n${legend.label}", style: normalStyle)]),
      textDirection: TextDirection.ltr);

    textPainter.layout(maxWidth: rect.width);

    textPainter.paint(canvas, new Offset(reverse ? rect.right - textPainter.width - 5.0 : rect.left + 5.0,
      rect.bottom - (rect.height / 2) - textPainter.height / 2));
  }

  Rect _getLegendRect(double originX, double originY, double anchorX, double anchorY) {
    if (anchorX >= originX) {
      return new Rect.fromLTWH(anchorX + padding, anchorY - height / 2, width, height);
    } else {
      return new Rect.fromLTWH(anchorX - width - padding, anchorY - height / 2, width, height);
    }
  }

  Rect _fitRect(Rect rect, Size size) {
    return rect;
  }
}

class DonutChartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataSet dataSet = new DataSet(
      name: "dataSet1",
      label: "Data Set 1",
      data: <Entry>[
        new Entry(5.0),
        new Entry(15.0),
        new Entry(20.0),
        new Entry(60.0),
      ],
    );

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
                  dataSet,
                ],
                scales: {},
                axes: <chart.Axis>[
                  new DonutChartAxis(
                    innerRadius: 50.0,
                    outerRadius: 95.0,
                    width: 80.0,
                    height: 50.0,
                    padding: 10.0,
                    dataSet: dataSet,
                    legends: <Legend>[
                      new Legend(label: "SOCIAL", icon: "social.png"),
                      new Legend(label: "LOCATION", icon: "location.png"),
                      new Legend(label: "USER PROFILE", icon: "profile.png"),
                      new Legend(label: "OTHER", icon: "other.png")
                    ]
                  ),
                ],
                colors: <Color>[
                  const Color(0xFFFF8540),
                  const Color(0xFFB269EE),
                  const Color(0xFF4AD8CF),
                  const Color(0xFFBDBCC8),
                ],
                radius: 100.0,
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