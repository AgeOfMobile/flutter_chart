import 'package:flutter/painting.dart';
import 'package:flutter_chart/scale/scale.dart';

class CategoryScale extends Scale<String> {
  CategoryScale({
    String name,
    this.values,
    String domainMin = "",
    String domainMax = ""
  })
    : super(domainMin: domainMin, domainMax: domainMax);

  final List<String> values;

  @override
  double scale(String domainValue, int index, double range) {
    assert(values.length > 1);
    return index * range / (values.length - 1);
  }
}