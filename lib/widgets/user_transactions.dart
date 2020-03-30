import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget { //communication between newTx and TxList
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 6999, date: DateTime.now()),
    Transaction(id: 't2', title: 'new pc', amount: 6999, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
      // cannot do _userTransaction = ..., cause it's final, but add you can do
    });
        
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NewTransaction(_addNewTransaction), // PASS A FUNCTION HANDLER CAUSE IT'S A PRIVATE FUNCTION!!!!!!!!
      TransactionList(_userTransactions)
    ],);
  }
}