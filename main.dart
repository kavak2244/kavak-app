import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kavak App',
      home: Scaffold(
        appBar: AppBar(title: Text('Kavak App')),
        body: Center(child: Text('Hello Kavak!')),
      ),
    );
  }
}