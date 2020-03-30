import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget { //text field for input new transaction
  final Function addTx; //necessary for onPressed button command
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);
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
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountController,
              ),
              FlatButton(
                child: Text('Add transaction'),
                onPressed: () {
                  addTx(titleController.text, double.parse(amountController.text));
                },
                textColor: Colors.purple,
              )
            ],
          ),
        
      ),
    );
  }
}
