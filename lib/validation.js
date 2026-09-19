import { CATEGORIES } from "@/lib/categories";

export function validateExpense(expense) {
  const errors = {};
  // 空の{}を作成し、エラーがあればその中に追加していく
  const categoryCheck = CATEGORIES.some((c) => c.value === expense.category);

  if (!expense.amount || isNaN(expense.amount) || expense.amount <= 0) {
    errors.amount = "金額は正の数である必要があります";
  }
  if (!categoryCheck || expense.category.trim() === "") {
    errors.category = "カテゴリは必須です";
  }
  return errors.amount || errors.category || null;
}
