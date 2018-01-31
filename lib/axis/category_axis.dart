import 'package:flutter/painting.dart';
import 'package:flutter_chart/axis/axis.dart' as chart;
import 'package:flutter_chart/scale/category_scale.dart';

class CategoryAxis implements chart.Axis {
  CategoryAxis({
    this.scale,
    this.color,
    this.textStyle = const TextStyle(color: const Color(0xFF000000), fontSize: 10.0)
  });

  final CategoryScale scale;
  final Color color;
  final TextStyle textStyle;

  @override
  void draw(Canvas canvas, Size size) {
    final itemWidth = size.width / scale.values.length;
    Paint paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    paint.style = PaintingStyle.stroke;

    for (int i = 0; i < scale.values.length; i++) {
      double dx = scale.scale("", i, size.width);
      TextSpan textSpan = new TextSpan(style: textStyle, text: scale.values[i]);
      TextPainter textPainter = new TextPainter(text: textSpan,
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth:  itemWidth);
      double textWidth = textPainter.width;
      textPainter.paint(canvas, new Offset(dx - textWidth / 2.0, size.height));

//      double markX = dx;
//      double markY = size.height;
//      canvas.drawLine(new Offset(markX, markY), new Offset(markX, markY - 10), paint);
    }
  }
}