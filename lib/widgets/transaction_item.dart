import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
    @required this.startEdit,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;
  final Function startEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      onDismissed: (direction) {
        deleteTx(transaction.id);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Transaction deleted"),
        ));
      },
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          onLongPress: () => startEdit(
              context,
              transaction.id,
              transaction.title,
              transaction.date,
              transaction.amount),
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$${transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              DateFormat.yMMMd().format(transaction.date)),
          trailing: MediaQuery.of(context).size.width > 460  //based of width, different buttons are rendered
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  onPressed: () {deleteTx(transaction.id);},
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () => deleteTx(transaction.id),
                ),
        ),
      ),
    );
  }
}