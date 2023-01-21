import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addTx;
  const AddTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  datePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      selectedDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.text,
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          TextField(
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: const InputDecoration(
                labelText: 'amount',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    datePicker();
                  },
                  child: Text(
                    selectedDate == null
                        ? 'Choose Date'
                        : DateFormat.yMd().format(selectedDate!).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    submitData();
                  },
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text),
        selectedDate);
    debugPrint(titleController.text);
    debugPrint(amountController.text);
    Navigator.pop(context);
  }
}
