import 'package:expensives/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.removeTransaction,
    @required this.tr,
  }) : super(key: key);

  final void Function(Transaction p1) removeTransaction;
  final Transaction tr;

  @override
  Widget build(BuildContext context) {
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
  }
}
