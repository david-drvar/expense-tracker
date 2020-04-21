import 'package:expense_tracker/models/transaction.dart';
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
          ? Column(
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
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                //index currently rendering
                return Dismissible(
                  key: Key(transactions[index].id),
                  onDismissed: (direction) {
                    deleteTx(transactions[index].id);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Transaction deleted"),
                    ));
                  },
                  background: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white,),
                  ),
                  secondaryBackground: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(Icons.delete, color: Colors.white,),
                  ),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      onLongPress: () => startEdit(context, transactions[index].id, transactions[index].title, transactions[index].date, transactions[index].amount),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete,
                      //     color: Theme.of(context).errorColor,
                      //   ),
                      //   onPressed: () => deleteTx(transactions[index].id),
                      // ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length, //how many we have to render
            ),
    );
  }
}
