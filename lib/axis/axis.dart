import 'package:flutter/painting.dart';

abstract class Axis<T> {
  void draw(Canvas canvas, Size size);
}