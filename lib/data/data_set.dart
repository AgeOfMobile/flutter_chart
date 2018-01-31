import 'package:flutter_chart/data/entry.dart';
import 'package:meta/meta.dart';

class DataSet {
  DataSet({
    @required this.name,
    this.label,
    @required this.data
  });

  final String name;
  final String label;
  final List<Entry> data;
}
