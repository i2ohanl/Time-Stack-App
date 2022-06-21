import 'package:flutter/material.dart';
import 'package:time_tracker/timeStack.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second page')),
      body: Container(
        child: const Square(height: 100.0, width: 100.0, color: Colors.blueGrey,),
      ),
    );
  }
}