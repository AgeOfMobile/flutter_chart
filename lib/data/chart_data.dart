import 'package:flutter/painting.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:flutter_chart/scale/scale.dart';
import 'package:flutter_chart/axis/axis.dart' as chart;
import 'package:meta/meta.dart';

class ChartData {
  ChartData({
    @required this.dataSets,
    @required this.scales,
    this.axes = const <chart.Axis>[],
    this.backgroundColor = const Color(0)
  });

  final List<DataSet> dataSets;
  final Map<String, Scale> scales;
  final List<chart.Axis> axes;
  final Color backgroundColor;
}