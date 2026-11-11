import 'package:expense_mobile/features/expenses/domain/expense.dart';

final List<Expense> expensesSample = [
  Expense(
    id: '1',
    category: 'food',
    amount: 4000,
    date: '2026-08-29',
    note: '家族と外食',
  ),
  Expense(
    id: '2',
    category: 'transport',
    amount: 1000,
    date: '2026-08-30',
    note: '交通費',
  ),
  Expense(
    id: '3',
    category: 'other',
    amount: 12000,
    date: '2026-07-31',
    note: '息子の誕生日プレゼント',
  ),
  Expense(
    id: '4',
    category: 'food',
    amount: 2000,
    date: '2026-06-21',
    note: 'ランチ',
  ),
  Expense(
    id: '5',
    category: 'transport',
    amount: 2000,
    date: '2026-04-21',
    note: '秋葉原バイト',
  ),
  Expense(
    id: '6',
    category: 'other',
    amount: 15000,
    date: '2026-05-15',
    note: '洋服購入',
  ),
];
