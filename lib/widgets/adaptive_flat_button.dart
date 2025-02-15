import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              'Choose Date',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: handler,
          )
        : FlatButton(
            child: Text(
              'Choose Date',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: handler,
          );
  }
}
