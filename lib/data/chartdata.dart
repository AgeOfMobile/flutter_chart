import 'package:flutter_chart/data/dataset.dart';

class ChartData {
  ChartData(this.dataSets, this.labels);

  List<String> labels;
  List<DataSet> dataSets;
}
