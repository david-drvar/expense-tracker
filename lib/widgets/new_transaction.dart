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

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  bool flag = false;

  void _submitData() {
    if (widget.id == null) {
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

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
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
              onSubmitted: (_) =>
                  _submitData(), //convention '_', I get an argument but I dont use it
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
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
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
    );
  }
}
