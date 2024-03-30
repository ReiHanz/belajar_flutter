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
          title: Text('Scale Gesture Demo'),
        ),
        body: Center(
          child: ScaleDemo(),
        ),
      ),
    );
  }
}

class ScaleDemo extends StatefulWidget {
  @override
  _ScaleDemoState createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<ScaleDemo> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (details) {
        setState(() {
          _scale = details.scale;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Scale me!',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
