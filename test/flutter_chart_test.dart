import 'package:flutter_chart/flutter_chart.dart';
import 'package:test/test.dart';

void main() {
  test('test LineChart painter', () {
    var chart = new Chart(new LineChartPainter(
      new LineChartData(<DataSet>[], <String>[])
    ));
  });
}
