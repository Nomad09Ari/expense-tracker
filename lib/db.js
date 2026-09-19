import { readFile } from "node:fs/promises";
import { writeFile } from "node:fs/promises";
import path from "node:path";

export async function getAll() {
  try {
    const data = await readFile(
      path.join(process.cwd(), "data", "expenses.json"),
      "utf-8"
    );
    return JSON.parse(data);
  } catch (error) {
    console.error("Error reading expenses.json:", error);
    return [];
  }
}

export async function create(expense) {
  const expenses = await getAll();
  const newExpense = { id: crypto.randomUUID(), ...expense };
  const updatedExpenses = [...expenses, newExpense];
  await writeFile(
    path.join(process.cwd(), "data", "expenses.json"),
    JSON.stringify(updatedExpenses, null, 2)
  );
  return newExpense;
}

export async function remove(id) {
  const expenses = await getAll();
  const updatedExpenses = expenses.filter((expense) => expense.id !== id);
  await writeFile(
    path.join(process.cwd(), "data", "expenses.json"),
    JSON.stringify(updatedExpenses, null, 2)
  );
  return expenses.length !== updatedExpenses.length ? true : false;
  // expenses.length !== updatedExpenses.lengthだけでもtrue/falseを返すことができるが、可読性のために三項演算子を使用している
}

export async function update(id, changes) {
  const expenses = await getAll();
  const changedExpenses = expenses.map((expense) =>
    expense.id === id ? { ...expense, ...changes } : expense
  );
  await writeFile(
    path.join(process.cwd(), "data", "expenses.json"),
    JSON.stringify(changedExpenses, null, 2)
  );
  return changedExpenses.find((expense) => expense.id === id);
  // もし、expense.idが指定されたidと一致する場合、その支出を更新するために、
  // スプレッド構文を使用して既存の支出オブジェクトと変更内容をマージし、新しいオブジェクトを作成する。
  // そうでない場合は、元の支出オブジェクトをそのまま返す。
}
