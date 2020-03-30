

import 'package:expense_tracker/widgets/user_transactions.dart';
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
  

  // String titleInput; //input is always String!
  // String amountInput; //we can have no-final vars because we don't have to update our interface
  // final titleController = TextEditingController(); //BETTER ALTERNATIVE!
  // final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                // if you want to increase Card's width you can do it by wraping
                // Text with a Container or wraping whole Card in a Container
                color: Colors.blue,
                child: Text('CHART'),
                elevation: 5,
              ),
            ),
            UserTransactions()
          ],
        ));
  }
}
