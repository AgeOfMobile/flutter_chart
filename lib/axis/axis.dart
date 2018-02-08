import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

enum AxisPosition {
  left,
  top,
  right,
  bottom,
  undefined
}

abstract class Axis<T> {
  final AxisPosition position;

  Axis({ @required this.position });

  void draw(Canvas canvas, Size size);
}