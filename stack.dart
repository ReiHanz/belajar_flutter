import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final imageUrl1 = 'https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-large-annotated.png';
  final imageUrl2 = 'https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-rating-row.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack Layout Example'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.grey,
              ),
              Positioned(
                top: 50,
                left: 50,
                child: Image.network(
                  imageUrl1,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 50,
                right: 50,
                child: Image.network(
                  imageUrl2,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
