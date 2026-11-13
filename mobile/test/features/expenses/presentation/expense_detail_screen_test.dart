import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_mobile/features/expenses/presentation/expense_detail_screen.dart';
import 'package:expense_mobile/features/expenses/domain/expense.dart';

void main() {
  testWidgets('支出の詳細が画面に表示される', (WidgetTester tester) async {
    final longNote = 'とても長い文章' * 20;
    final expense = Expense(
      id: '1',
      category: 'food',
      amount: 4000,
      date: '2026-08-29',
      note: longNote,
    );
    await tester.pumpWidget(
      MaterialApp(home: ExpenseDetailScreen(expense: expense)),
    );

    expect(find.text('food'), findsOneWidget);
    expect(find.text('4000円'), findsOneWidget);
    expect(find.text('2026-08-29'), findsOneWidget);

    final expenseNote = tester.widget<Text>(find.text(longNote));

    expect(expenseNote.maxLines, isNull);
    expect(expenseNote.overflow, isNull);
  });

  testWidgets('存在しない支出のとき、「該当支出がありません」が表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: ExpenseDetailScreen(expense: null)),
    );

    expect(find.text('該当支出がありません'), findsOneWidget);
    expect(find.text('カテゴリ'), findsNothing);
  });
}
