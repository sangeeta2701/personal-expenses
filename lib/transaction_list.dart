import 'package:flutter/material.dart';
import 'transaction_item.dart';
import 'transaction.dart';
// import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // final List<Transaction> _userTransaction = [
  //   Transaction(
  //     id: 't1',
  //     title: 'New Shoes',
  //     amount: 69.99,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Weekly Groceries',
  //     amount: 16.53,
  //     date: DateTime.now(),
  //   )
  // ];

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // ignore_for_file: avoid_print
    print('build() TransactionList');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'No Transaction added yet!',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'OpenSans'),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20.0,
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
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              // ignore: prefer_const_constructors
              return TransactionItem(
                  transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
            // children: (transactions.map((tx) {}).toList()),
          );
  }
}
