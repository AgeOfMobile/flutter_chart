import 'package:flutter/painting.dart';
import 'package:flutter_chart/scale/scale.dart';

class CategoryScale extends Scale<String> {
  CategoryScale({
    String name,
    this.values,
    String min = "",
    String max = ""
  })
    : super(name: name, min: min, max: max);

  final List<String> values;

  @override
  double scale(String domainValue, int index, double range) {
    assert(values.length > 1);
    return index * range / (values.length - 1);
  }
}