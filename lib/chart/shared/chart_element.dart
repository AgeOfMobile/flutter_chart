import 'dart:ui';

abstract class ChartElement {
  void prepaint(Canvas canvas, Size size);
  void postpaint(Canvas canvas, Size size);
}