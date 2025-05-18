class Transaction {
  int montant;
  DateTime date;
  String description;
  String category;
  String type;

  Transaction({
    required this.montant,
    required this.date,
    required this.description,
    required this.category,
    required this.type,
  });
}
