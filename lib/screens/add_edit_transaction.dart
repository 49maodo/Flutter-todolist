import 'package:flutter/material.dart';
import 'package:rattrap/contant/categories.dart';
import 'package:rattrap/models/transaction.dart';

class AddEditTransaction extends StatefulWidget {
  final Transaction? transaction;
  const AddEditTransaction({super.key, this.transaction});

  @override
  State<AddEditTransaction> createState() => _AddEditTransactionState();
}

class _AddEditTransactionState extends State<AddEditTransaction> {
  final _formKey = GlobalKey<FormState>();
  late int _montant;
  late DateTime _date;
  late String _description;
  late String _category;
  late String _type;

  @override
  void initState() {
    super.initState();
    _montant = widget.transaction?.montant ?? 0;
    _date = widget.transaction?.date ?? DateTime.now();
    _description = widget.transaction?.description ?? '';
    _category = widget.transaction?.category ?? 'Alimentation';
    _type = widget.transaction?.type ?? 'Dépense';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transaction == null
              ? 'Ajouter un transaction'
              : 'Modifier le transaction',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _montant.toString(),
                decoration: const InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  // Check if the value > 0
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _montant = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _date.toString(),
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _date) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categorie'),
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Dépense'),
                value: 'Dépense',
                groupValue: _type,
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Revenu'),
                value: 'Revenu',
                groupValue: _type,
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      Transaction(
                        montant: _montant,
                        date: _date,
                        description: _description,
                        category: _category,
                        type: _type,
                      ),
                    );
                  }
                },
                child:
                    Text(widget.transaction == null ? 'Ajouter' : 'Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
