import 'dart:ui';

import 'package:meta/meta.dart';

abstract class Scale<T> {
  Scale({this.domainMin, this.domainMax });

  final T domainMin;
  final T domainMax;

  double scale(T domainValue, int index, double range);
}