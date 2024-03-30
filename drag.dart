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
          title: Text('Drag Gesture Demo'),
        ),
        body: Center(
          child: DragDemo(),
        ),
      ),
    );
  }
}

class DragDemo extends StatefulWidget {
  @override
  _DragDemoState createState() => _DragDemoState();
}

class _DragDemoState extends State<DragDemo> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _offset = details.globalPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });
      },
      child: Stack(
        children: [
          Positioned(
            left: _offset.dx - 50,
            top: _offset.dy - 50,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
