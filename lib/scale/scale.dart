import 'dart:ui';

import 'package:meta/meta.dart';

abstract class Scale<T> {
  Scale({ @required this.name, this.min, this.max, this.ticks });

  final String name;
  final T min;
  final T max;
  final List<T> ticks;

  double scale(T domainValue, int index, double range);
}