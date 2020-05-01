import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //list of all transactions so far
  final List<Transaction> transactions;
  final Function deleteTx;
  final Function startEdit;

  TransactionList(this.transactions, this.deleteTx, this.startEdit);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.7,  //60% of available height
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constrains) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                //index currently rendering
                return TransactionItem(transaction: transactions[index], deleteTx: deleteTx, startEdit: startEdit);
              },
              itemCount: transactions.length, //how many we have to render
            ),
    );
  }
}


