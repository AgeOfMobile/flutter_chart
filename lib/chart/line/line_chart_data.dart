import 'package:flutter/widgets.dart';
import 'package:flutter_chart/data/chart_data.dart';
import 'package:flutter_chart/data/data_set.dart';
import 'package:meta/meta.dart';

class LineChartData extends ChartData {
  LineChartData({
    @required List<DataSet> dataSets,
    this.lineColors,
    this.lineWidth: 0.5,
    this.dotColors,
    this.gridLineColor: const Color(0xFF666666),
  })
      : assert(dataSets != null),
        assert(lineColors == null || (lineColors.length == dataSets.length)),
        assert(dotColors == null || (dotColors.length == dataSets.length)),
        super(dataSets: dataSets) {
    if (this.lineColors == null) {
      this.lineColors = dataSets.map((d) => new Color(0xFFFFFFFF)).toList();
    }
    if (this.dotColors == null) {
      this.dotColors = dataSets.map((d) => new Color(0xFFFFFFFF)).toList();
    }
  }

  List<Color> lineColors;
  double lineWidth;
  List<Color> dotColors;
  Color gridLineColor;
}