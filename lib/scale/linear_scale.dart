import 'dart:ui';

import 'package:flutter_chart/scale/scale.dart';

class LinearScale extends Scale<double> {

  LinearScale({
    String name,
    double domainMin = 0.0,
    double domainMax = 1.0}
  )
    : super(name: name, min: domainMin, max: domainMax) {
    assert(domainMin < domainMax);
  }

  @override
  double scale(double domainValue, int index, double range) {
    return domainValue * range / (max - min);
  }
}