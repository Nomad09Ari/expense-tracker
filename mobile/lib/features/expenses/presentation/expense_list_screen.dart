import 'package:flutter/material.dart';
import 'package:expense_mobile/features/expenses/application/expense_calculation.dart';
import 'package:expense_mobile/features/expenses/domain/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final expensesTotalAmount = calculateTotalAmount(expenses: expenses);
    return Scaffold(
      appBar: AppBar(title: const Text('Expense List')),
      body: Column(
        children: [
          Expanded(
            child: expenses.isEmpty
                ? const Center(child: Text('支出がありません'))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
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
