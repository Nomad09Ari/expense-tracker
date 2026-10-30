class Expense {
  final String id;
  final int amount;
  final String category;
  final String? note;
  final String date;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });
}
