import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //text field for input new transaction
  final Function addTx; //necessary for onPressed button command

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_titleController.text.isNotEmpty &&
        double.parse(_amountController.text) > 0 && _selectedDate!=null)
      widget.addTx(_titleController.text, double.parse(_amountController.text), _selectedDate);

    // widget.addTx(            FOR SOME REASON THIS BLOCK CASES DOUBLE ADD TO THE TX_LIST
    // titleController.text,
    // double.parse(amountController.text),
    // );

    Navigator.of(context)
        .pop(); //context available class-wise, this method closes ModalBottomSheet when TX submitted
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        if (pickedDate == null) {
          _selectedDate = null;
          return;
        }
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (value) {
              //   amountInput = value;
              // },
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
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
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
