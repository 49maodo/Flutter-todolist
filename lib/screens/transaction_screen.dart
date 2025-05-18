import 'package:flutter/material.dart';
import 'package:rattrap/models/transaction.dart';
import 'package:rattrap/models/transactions.dart';
import 'package:rattrap/screens/add_edit_transaction.dart';
import 'package:rattrap/screens/categorie_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  void _addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  void _editTransaction(int index, Transaction transaction) {
    setState(() {
      transactions[index] = transaction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Solde total'),
          subtitle: Text(
            '${transactions.fold(0, (sum, item) => sum + (item.type == 'Revenu' ? item.montant : -item.montant))} Fr',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: transactions.fold(
                          0,
                          (sum, item) =>
                              sum +
                              (item.type == 'Revenu'
                                  ? item.montant
                                  : -item.montant)) >=
                      0
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          trailing: Icon(
            transactions.fold(
                        0,
                        (sum, item) =>
                            sum +
                            (item.type == 'Revenu'
                                ? item.montant
                                : -item.montant)) >=
                    0
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: transactions.fold(
                        0,
                        (sum, item) =>
                            sum +
                            (item.type == 'Revenu'
                                ? item.montant
                                : -item.montant)) >=
                    0
                ? Colors.green
                : Colors.red,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(transactions[index].description),
            subtitle: Text(
              '${transactions[index].date.day}/${transactions[index].date.month}/${transactions[index].date.year}',
            ),
            leading: Icon(
              transactions[index].type == 'Dépense'
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: transactions[index].type == 'Dépense'
                  ? Colors.red
                  : Colors.green,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${transactions[index].montant} Fr',
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final updatedTransaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTransaction(
                          transaction: transactions[index],
                        ),
                      ),
                    );
                    if (updatedTransaction != null) {
                      _editTransaction(index, updatedTransaction);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      transactions.removeAt(index);
                    });
                  },
                ),
              ],
            ), // Display the amount with currency
          );
        },
        // Add a floating open AddEditTransaction pag
      ),
      // Bottom navigation bar item
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TransactionScreen()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTransaction = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTransaction(),
            ),
          );
          if (newTransaction != null) {
            _addTransaction(newTransaction);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Catégories'),
//       ),
//       body: Center(
//         child: Text('Liste des catégories'),
//       ),
//     );
//   }
// }
