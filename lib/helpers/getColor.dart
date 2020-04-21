import 'package:flutter/material.dart';

Color getColor(BuildContext context, double percent) {
  if (percent > 0.8) {
    return Colors.red;
  } else if (percent > 0.4) {
    return Colors.yellow;
  } else {
    return Theme.of(context).primaryColor;
  }
}
