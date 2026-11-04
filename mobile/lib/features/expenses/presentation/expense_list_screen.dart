import 'package:flutter/material.dart';
import 'package:expense_mobile/features/expenses/data/expenses_sample.dart';
import 'package:expense_mobile/features/expenses/application/expense_calculation.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expensesTotalAmount = calculateTotalAmount(expenses: expensesSample);
    return Scaffold(
      appBar: AppBar(title: const Text('Expense List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
          ),
          ListTile(
            title: const Text('合計'),
            trailing: Text('$expensesTotalAmount円'),
          ),
        ],
      ),
    );
  }
}
