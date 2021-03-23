import 'package:expensives/components/transaction_item.dart';
import 'package:expensives/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction) removeTransaction;
  final double height;
  TransactionList(this.transactions, this.removeTransaction, this.height);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.05,
                  child: FittedBox(
                    child: Text(
                      'Nenhuma Transação Cadastrada',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  height: height * 0.60,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                removeTransaction: removeTransaction,
                tr: tr,
              );
            },
          );
  }
}
