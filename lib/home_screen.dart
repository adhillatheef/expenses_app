import 'package:expenses_app/chart.dart';
import 'package:expenses_app/transaction_list.dart';
import 'package:expenses_app/transactions.dart';
import 'package:flutter/material.dart';
import 'add_transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> userTransaction = [];
  List<Transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.time!.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  addNewTransaction(String title, double amount, DateTime selectedDate) {
    final transaction = Transaction(
        title: title,
        amount: amount,
        time: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      userTransaction.add(transaction);
    });
  }

  deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTransaction(addNewTransaction));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Expenses App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => AddTransaction(addNewTransaction));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.amber,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  flex: 1, child: Chart(recentTransactions: recentTransaction)),
              Expanded(
                  flex: 3,
                  child: TransactionList(
                    userTransaction,
                    deleteTx: deleteTransaction,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
