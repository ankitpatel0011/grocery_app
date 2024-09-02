import 'package:flutter/material.dart';

///Vertical Space
Widget heightSpace(
  double h,
) {
  return SizedBox(
    height: h,
  );
}

///Horizontal Space
Widget widthSpace(
  double w,
) {
  return SizedBox(
    width: w,
  );
}

/// Screen size
double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String firstLetterCapital({required String input}) {
  if (input.isEmpty) return input;
  return List.from(input
          .replaceAll("_", ",")
          .split(",")
          .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
          .toList())
      .join(",")
      .replaceAll(",", " ");
}
