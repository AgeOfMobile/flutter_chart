import 'package:flutter/widgets.dart';
import 'package:flutter_chart/data/chart_data.dart';
import 'package:meta/meta.dart';

abstract class Chart<T extends ChartData> extends StatefulWidget {
  Chart({ @required this.data, this.animationDuration: const Duration(milliseconds: 500) });

  final T data;
  final Duration animationDuration;

  ChartPainter<T> createChartPainter(T data, Animation<double> animation);

  @override
  State<StatefulWidget> createState() {
    return new _ChartState();
  }
}

class _ChartState extends State<Chart> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      value: 0.0,
      vsync: this,
      duration: this.widget.animationDuration,
    )
    ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return new CustomPaint(
          painter: this.widget.createChartPainter(this.widget.data, _controller),
        );
      },
    );
  }
}

abstract class ChartPainter<T extends ChartData> extends CustomPainter {
  ChartPainter({
    @required this.data,
    this.animation
  }): super(repaint: animation);

  final T data;
  final Animation<double> animation;
}
