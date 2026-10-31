import 'package:expense_mobile/features/expenses/domain/expense.dart';

final List<Expense> expensesSample = [
  Expense(
    id: '1',
    category: 'food',
    amount: 1500,
    note: 'Groceries',
    date: "2026-06-15",
  ),
  Expense(
    id: '2',
    category: 'transfort',
    amount: 7500,
    note: 'Metro fare',
    date: "2026-06-14",
  ),
  Expense(
    id: '3',
    category: 'other',
    amount: 3000,
    note: 'Movie tickets',
    date: "2026-06-13",
  ),
];
