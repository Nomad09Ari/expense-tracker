import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_mobile/features/expenses/presentation/expense_list_screen.dart';
import 'package:expense_mobile/features/expenses/data/expenses_sample.dart';
import 'package:expense_mobile/features/expenses/domain/expense.dart';

void main() {
  testWidgets('支出の一覧を画面に表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: ExpenseListScreen(expenses: expensesSample)),
    );

    expect(find.text('家族と外食'), findsOneWidget);
    expect(find.text('36000円'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(7)); // 6件の支出 + 合計
  });

  testWidgets('支出が 0 件のとき、メッセージと合計 0 円だけが表示される', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ExpenseListScreen(expenses: [])));

    expect(find.text('支出がありません'), findsOneWidget);
    expect(find.text('0円'), findsOneWidget); // 合計の0円
    expect(find.byType(ListTile), findsOneWidget); // 合計のListTileのみ
  });

  testWidgets('支出のメモが長い場合、1行に省略して表示される', (WidgetTester tester) async {
    final longNote = 'とても長い文章' * 20;
    final expenses = [
      Expense(
        id: '1',
        category: 'food',
        amount: 4000,
        date: '2026-08-29',
        note: longNote,
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(home: ExpenseListScreen(expenses: expenses)),
    );

    final expenseNote = tester.widget<Text>(find.text(longNote));

    expect(expenseNote.maxLines, 1);
    expect(expenseNote.overflow, TextOverflow.ellipsis);
  });

  testWidgets('文字を3倍にしても、画面が崩れないで表示される', (WidgetTester tester) async {
    // 文字サイズ（倍率）を3.0倍に変更
    tester.platformDispatcher.textScaleFactorTestValue = 3.0;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    // 画面サイズをスマホ向け設定
    tester.view.physicalSize = const Size(400, 700);
    addTearDown(tester.view.resetPhysicalSize);

    tester.view.devicePixelRatio = 1.0; // 計算を簡単にするため1.0に固定
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(home: ExpenseListScreen(expenses: expensesSample)),
    );

    // nullじゃなければ、エラー内容が見れる
    expect(tester.takeException(), isNull);
  });
}
