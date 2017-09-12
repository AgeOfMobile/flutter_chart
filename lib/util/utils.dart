import 'dart:math';

import 'dart:ui';

List<Offset> calculateControlPoints(
    Offset firstPoint,
    Offset middlePoint,
    Offset afterPoint,
    double tension) {
  // Props to Rob Spencer at scaled innovation for his post on splining between points
  // http://scaledinnovation.com/analytics/splines/aboutSplines.html

  // This function must also respect "skipped" points

//  var previous = firstPoint.skip ? middlePoint : firstPoint;
  var previous = firstPoint;
  var current = middlePoint;
//  var next = afterPoint.skip ? middlePoint : afterPoint;
  var next = afterPoint;

  var d01 = sqrt(pow(current.dx - previous.dx, 2) + pow(current.dy - previous.dy, 2));
  var d12 = sqrt(pow(next.dx - current.dx, 2) + pow(next.dy - current.dy, 2));

  var s01 = d01 / (d01 + d12);
  var s12 = d12 / (d01 + d12);

  var fa = tension * s01; // scaling factor for triangle Ta
  var fb = tension * s12;

  return <Offset>[
      new Offset(current.dx - fa * (next.dx - previous.dx),
          current.dy - fa * (next.dy - previous.dy)),
      new Offset(current.dx + fb * (next.dx - previous.dx),
          current.dy + fb * (next.dy - previous.dy))
  ];
}