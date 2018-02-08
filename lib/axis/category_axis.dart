import 'package:flutter/painting.dart';
import 'package:flutter_chart/axis/axis.dart' as chart;
import 'package:flutter_chart/scale/category_scale.dart';

class CategoryAxis extends chart.Axis {
  CategoryAxis({
    chart.AxisPosition position = chart.AxisPosition.bottom,
    this.scale,
    this.color,
    this.textStyle = const TextStyle(color: const Color(0xFF000000), fontSize: 10.0),
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    this.padding = 10.0
  }): super(position: position);

  final CategoryScale scale;
  final Color color;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double padding;

  @override
  void draw(Canvas canvas, Size size) {
    final itemWidth = size.width / scale.values.length;
    Paint paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    paint.style = PaintingStyle.stroke;

    for (int i = 0; i < scale.values.length; i++) {
      double dx = scale.scale("", i, size.width);
      TextSpan textSpan = new TextSpan(style: textStyle, text: scale.values[i]);
      TextPainter textPainter = new TextPainter(
        text: textSpan,
        textAlign: textAlign,
        textDirection: textDirection
      );
      textPainter.layout(maxWidth:  itemWidth);
      double textWidth = textPainter.width;
      textPainter.paint(canvas, new Offset(dx - textWidth / 2.0, size.height + this.padding));
    }
  }
}