import 'package:flutter/material.dart';
import './timeStack.dart';
import './history_page.dart';

void main(List<String> args) {
  runApp(MyApp());  
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light(primary: Colors.purple)),
      home: const TimeStack(),
      routes: {
        '/historyPage': (_) => HistoryPage()
      },
    );
  }
}