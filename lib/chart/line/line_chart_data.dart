import 'dart:ui' show Color;

import 'package:flutter_chart/axis/axis.dart';
import 'package:flutter_chart/data/chart_data.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:flutter_chart/scale/scale.dart';
import 'package:meta/meta.dart';

class LineChartData extends ChartData {
  LineChartData({
    @required List<DataSet> dataSets,
    @required Map<String, Scale> yScales,
    @required this.xScales,
    List<Axis> axes,
    Color backgroundColor,
    this.colors,
    this.tension = 0.3,
    this.lineWidth = 0.5,
    this.dotColors,
  }):
    assert(dataSets != null),
    assert(yScales != null),
    assert(xScales != null),
    assert(colors == null || (colors.length >= dataSets.length)),
    assert(dotColors == null || (dotColors.length >= dataSets.length)),
    super(
      dataSets: dataSets,
      scales: yScales,
      axes: axes,
      backgroundColor: backgroundColor,
    ) {
    if (this.colors == null) {
      this.colors = dataSets.map((d) => new Color(0xFFFFFFFF)).toList();
    }
    if (this.dotColors == null) {
      this.dotColors = dataSets.map((d) => new Color(0xFFFFFFFF)).toList();
    }
  }

  List<Color> colors;
  List<Color> dotColors;

  final double lineWidth;
  final double tension;
  final Map<String, Scale> xScales;
}
