import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card( // if you want to increase Card's width you can do it by wraping
                          // Text with a Container or wraping whole Card in a Container
                color: Colors.blue,
                child: Text('CHART'),
                elevation: 50,
              ),
            ),
            Card(
              child: Text('LIST OF TX'),
            )
          ],
        ));
  }
}
