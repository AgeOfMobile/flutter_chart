import 'dart:ui';

import 'package:flutter_chart/axis/axis.dart';
import 'package:flutter_chart/scale/linear_scale.dart';

class LinearAxis extends Axis {
  LinearAxis({
    AxisPosition position,
    this.scale,
    this.tickCount = 5,
    this.gridLineColor = const Color(0xFF000000)
  }): super(position: position);

  final LinearScale scale;
  final int tickCount;
  final Color gridLineColor;

  @override
  void draw(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = this.gridLineColor;
    final delta = size.height / (tickCount - 1);

    for (int i = 0; i < tickCount; i++) {
      var y = size.height - i * delta;
      canvas.drawLine(new Offset(0.0, y), new Offset(size.width, y), paint);
    }
  }
}