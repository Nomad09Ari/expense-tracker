import 'package:go_router/go_router.dart';
import 'package:expense_mobile/features/expenses/presentation/expense_list_screen.dart';
import 'package:expense_mobile/features/expenses/presentation/expense_detail_screen.dart';
import 'package:expense_mobile/features/expenses/data/expenses_sample.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/', // このURLの時この画面を出す
        builder: (context, state) =>
            ExpenseListScreen(expenses: expensesSample),

        routes: [
          GoRoute(
            path: 'expenses/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final expense = expensesSample
                  .where((expense) => expense.id == id)
                  .firstOrNull;

              return ExpenseDetailScreen(expense: expense);
            },
          ),
        ],
      ),
    ],
  );
}
