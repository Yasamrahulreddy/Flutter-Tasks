import 'package:flutter/material.dart';
import 'package:switchlisttile/model/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwitchListTile',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SwitchListTile'),
        ),
        body: Center(
          child: DataListView(),
        ),
      ),
    );
  }
}
