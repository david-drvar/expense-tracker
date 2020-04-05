import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget { //text field for input new transaction
  final Function addTx; //necessary for onPressed button command

  NewTransaction(this.addTx);

  

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    if (titleController.text.isNotEmpty && double.parse(amountController.text)>0)
      widget.addTx(titleController.text, double.parse(amountController.text));

    // widget.addTx(            FOR SOME REASON THIS BLOCK CASES DOUBLE ADD TO THE TX_LIST
    // titleController.text,
    // double.parse(amountController.text),
    // ); 

    Navigator.of(context).pop();  //context available class-wise, this method closes ModalBottomSheet when TX submitted
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
                controller: titleController,
                
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(), //convention '_', I get an argument but I dont use it
              ),
              FlatButton(
                child: Text('Add transaction'),
                onPressed: submitData,
                textColor: Colors.black,
              )
            ],
          ),
        
      ),
    );
  }
}
