import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //text field for input new transaction
  final Function addTx; //necessary for onPressed button command
  final String id;
  final String title;
  DateTime date;
  final double amount;

  NewTransaction(this.addTx,
      [this.id,
      this.title,
      this.date,
      this.amount]); //if id is set then EDIT is carried out

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> with WidgetsBindingObserver {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  bool flag = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); //adding listener
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
    super.didChangeAppLifecycleState(state);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); //remove listener
    super.dispose();
  }

  void _submitData() {
    if (widget.id == null) {  //if it's a new object
      if (_titleController.text.isNotEmpty &&
          double.parse(_amountController.text) > 0 &&
          _selectedDate != null)
        widget.addTx(_titleController.text,
            double.parse(_amountController.text), _selectedDate);
    } else {
      if (_titleController.text.isNotEmpty &&
          double.parse(_amountController.text) > 0)
        widget.addTx(_titleController.text,
            double.parse(_amountController.text), widget.date, widget.id);
    }

    Navigator.of(context)
        .pop(); //context available class-wise, this method closes ModalBottomSheet when TX submitted
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.date == null ? DateTime.now() : widget.date,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        if (pickedDate == null) {
          _selectedDate = null;
          return;
        }
        _selectedDate = pickedDate;
        widget.date = _selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) {
      _titleController.text = widget.title;
      if (widget.amount != null)
        _amountController.text = widget.amount.toString();
      flag = true;
    }

    return SingleChildScrollView(
      //make it scrollable so user can reach the input field
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                // onSubmitted: (_) =>
                //     _submitData(), //convention '_', I get an argument but I dont use it
              ),
              Container(
                height:
                    70, //cannot add it to row because row doesn't have height property
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: widget.date == null //a huge mess
                            ? Text(_selectedDate == null
                                ? 'No Date Chosen'
                                : 'Picked date ' +
                                    DateFormat.yMd().format(_selectedDate))
                            : Text(_selectedDate == null
                                ? 'Picked date ' +
                                    DateFormat.yMd().format(widget.date)
                                : 'Picked date ' +
                                    DateFormat.yMd().format(_selectedDate))),
                    AdaptiveFlatButton('Choose date', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction'),
                onPressed: _submitData,
                textColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
