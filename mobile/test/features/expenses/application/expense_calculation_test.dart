import 'package:flutter_test/flutter_test.dart';
import 'package:expense_mobile/features/expenses/application/expense_calculation.dart';
import 'package:expense_mobile/features/expenses/data/expenses_sample.dart';

void main() {
  group('合計値を計算するテスト', () {
    test('サンプル６件の合計値を計算する: 36000', () {
      final expensesTotalAmount = calculateTotalAmount(
        expenses: expensesSample,
      );
      expect(expensesTotalAmount, 36000);
    });

    test('空のリストの場合、合計値は０になる', () {
      final expensesTotalAmount = calculateTotalAmount(expenses: []);
      expect(expensesTotalAmount, 0);
    });
  });

  group('カテゴリで絞り込むテスト', () {
    test('allで絞り込んだ場合、6件になる', () {
      final filteredExpenses = filterExpensesByCategory(
        expenses: expensesSample,
        categoryFilter: 'all',
      );
      expect(filteredExpenses.length, 6);
    });

    test('foodで絞り込んだ場合、2件になる', () {
      final filteredExpenses = filterExpensesByCategory(
        expenses: expensesSample,
        categoryFilter: 'food',
      );
      expect(filteredExpenses.length, 2);
    });

    test('サンプル６件の中で存在しないカテゴリで絞り込んだ場合、空のリスト返す', () {
      final filteredExpenses = filterExpensesByCategory(
        expenses: expensesSample,
        categoryFilter: 'nonecategory',
      );
      expect(filteredExpenses.length, 0);
    });
  });

  test('foodで絞り込んだ場合、合計値を返す組み合わせのテスト: 6000', () {
    final filteredExpenses = filterExpensesByCategory(
      expenses: expensesSample,
      categoryFilter: 'food',
    );
    final expensesTotalAmount = calculateTotalAmount(
      expenses: filteredExpenses,
    );
    expect(expensesTotalAmount, 6000);
  });
}
