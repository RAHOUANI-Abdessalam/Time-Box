import 'package:flutter/material.dart';

Widget buildHeader(String title) {
  return Text(
    title,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget buildCard(Widget child) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    ),
  );
}
