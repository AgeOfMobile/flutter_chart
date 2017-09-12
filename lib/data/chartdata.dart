import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chart/data/dataset.dart';

class ChartData {
  ChartData({
    @required this.dataSets,
    this.backgroundColor: const Color(0)
  });

  final List<DataSet> dataSets;
  final Color backgroundColor;
}
