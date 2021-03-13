import 'package:expensives/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: ListTile(
                  trailing: MediaQuery.of(context).size.width < 480
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removeTransaction(tr),
                        )
                      : TextButton.icon(
                          onPressed: () => removeTransaction(tr),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          label: Text('Excluir'),
                        ),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('R\$ ' + tr.value.toStringAsFixed(2)),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                ),
              );
            },
          );
  }
}
