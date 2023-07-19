import 'pages/Budget.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/add_budget.dart';

void main() {
  for (var i in items) {
    total = total + i.money;
  }
  return runApp(
    MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/Budget': (context) => Home(),
        '/add_budget': (context) => Add()
      },
    ),
  );
}
