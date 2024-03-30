import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pan Gesture Demo'),
        ),
        body: Center(
          child: PanDemo(),
        ),
      ),
    );
  }
}

class PanDemo extends StatefulWidget {
  @override
  _PanDemoState createState() => _PanDemoState();
}

class _PanDemoState extends State<PanDemo> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });
      },
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Transform.translate(
            offset: _offset,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
