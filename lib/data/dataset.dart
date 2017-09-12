import 'package:flutter_chart/data/entry.dart';
import 'package:meta/meta.dart';

class DataSet {
  DataSet({this.label, @required this.data});

  final String label;
  final List<Entry> data;
}
