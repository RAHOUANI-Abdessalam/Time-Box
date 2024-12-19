import 'package:flutter/material.dart';

double getFontSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth < 600 ? baseSize * 0.8 : baseSize;
}

double getPadding(BuildContext context, double basePadding) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth < 600 ? basePadding * 0.7 : basePadding;
}

// String getMonth(int month) {
//   const months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];
//   return months[month - 1];
// }
