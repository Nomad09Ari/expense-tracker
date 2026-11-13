import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_mobile/router.dart';

void main() {
  testWidgets('一覧で支出をタップすると、詳細画面に移動する', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: createAppRouter()),
    );

    await tester.tap(find.text('家族と外食'));
    await tester.pumpAndSettle();

    expect(find.text('カテゴリ'), findsOneWidget);
    expect(find.text('2026-08-29'), findsOneWidget);
  });
}
