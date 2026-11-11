import 'package:flutter/material.dart';
import 'package:expense_mobile/features/expenses/domain/expense.dart';

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Detail')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(title: const Text('カテゴリ'), subtitle: Text(expense.category)),
          ListTile(
            title: const Text('金額'),
            subtitle: Text('${expense.amount}円'),
          ),
          ListTile(title: const Text('日付'), subtitle: Text(expense.date)),
          ListTile(
            title: const Text('メモ'),
            subtitle: Text(expense.note ?? 'No Note'),
          ),
        ],
      ),
    );
  }
}
