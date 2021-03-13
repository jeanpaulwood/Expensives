import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate;
  _onSubmitted() {
    final valor = double.tryParse(_valueController.text) ?? 0;
    final title = _titleController.text;
    if (title.isEmpty || valor <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, valor, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      } else {
        setState(() {
          _selectedDate = datePicked;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) => _onSubmitted,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmitted(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(8),
                    elevation: 5,
                    child: FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          _onSubmitted();
                        },
                        child: Text('Nova Transação'),
                        textColor: Theme.of(context).textTheme.button.color,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
