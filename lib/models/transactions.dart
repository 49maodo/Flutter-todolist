import 'package:rattrap/models/transaction.dart';

List<Transaction> transactions = [
  Transaction(
    montant: 100,
    date: DateTime.now(),
    description: 'Achat de nourriture',
    category: 'Alimentation',
    type: 'Dépense',
  ),
  Transaction(
    montant: 200,
    date: DateTime.now(),
    description: 'Vente de produit',
    category: 'Transport',
    type: 'Revenu',
  ),
];
