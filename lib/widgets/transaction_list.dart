import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTx;

  TransactionList(this._transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return _transactions.isEmpty ?
      LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
        },
      )
      :
      ListView.builder(
      itemBuilder: (ctx, index) {
        Transaction transaction = _transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5
          ),
          //child: Row(children: <Widget>[
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '\$${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20 * curScaleFactor,
                      color: Theme.of(context).primaryColorLight
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              transaction.title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transaction.date),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(transaction.id)
                )
              :
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(transaction.id),
                ),
          ),
        );
      },
      itemCount: _transactions.length,
    );
  }
}
