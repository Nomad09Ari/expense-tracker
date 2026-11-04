import 'package:flutter/material.dart';
import 'package:expense_mobile/features/expenses/data/expenses_sample.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense List')),
      body: ListView.builder(
        itemCount: expensesSample.length,
        itemBuilder: (context, index) {
          final expense = expensesSample[index];
          return ListTile(
            title: Text(expense.note ?? 'No Note'),
            subtitle: Text(expense.category),
            trailing: Text('${expense.amount}円'),
          );
        },
      ),
    );
  }
}
