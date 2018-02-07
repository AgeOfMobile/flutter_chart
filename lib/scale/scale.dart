import 'dart:ui';

import 'package:meta/meta.dart';

class Range<T> {
  final T min;
  final T max;

  Range({this.min, this.max});
}

abstract class Scale<T> {
  Scale({this.domainMin, this.domainMax });

  final T domainMin;
  final T domainMax;

  double scale(T domainValue, int index, double range);
}