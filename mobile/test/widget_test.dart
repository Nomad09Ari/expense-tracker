import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_mobile/features/expenses/presentation/expense_list_screen.dart';

void main() {
  testWidgets('支出の一覧を画面に表示される', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ExpenseListScreen()));

    expect(find.text('家族と外食'), findsOneWidget);
    expect(find.text('36000円'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(7)); // 6件の支出 + 合計
  });
}
