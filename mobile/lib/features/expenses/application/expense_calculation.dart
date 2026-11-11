import 'package:expense_mobile/features/expenses/domain/expense.dart';

List<Expense> filterExpensesByCategory({
  required List<Expense> expenses,
  required String categoryFilter,
}) {
  return categoryFilter == 'all'
      ? expenses
      : expenses
            .where((expense) => expense.category == categoryFilter)
            .toList();
}

int calculateTotalAmount({required List<Expense> expenses}) {
  return expenses.fold<int>(0, (sum, expense) => sum + expense.amount);
}
