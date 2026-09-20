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
  const newExpense = { ...expense, id: crypto.randomUUID() };
  // idを最後に書き、必ずサーバー生成の値が勝つようにする
  const updatedExpenses = [...expenses, newExpense];
  //配列の展開・連結(既存の配列全部+新しい1件を末尾に追加)
  // 配列のスプレッドはキーの上書きが起きません、単純に「並べる」だけです。
  await writeFile(
    path.join(process.cwd(), "data", "expenses.json"),
    JSON.stringify(updatedExpenses, null, 2)
  );
  return newExpense;
}

export async function remove(id) {
  const expenses = await getAll();
  const updatedExpenses = expenses.filter((expense) => expense.id !== id);
  //filterの役割は該当するobj以外を残す(除外する)ことです
  //新しい配列を作って返すのは.filter()の役割です。
  await writeFile(
    path.join(process.cwd(), "data", "expenses.json"),
    JSON.stringify(updatedExpenses, null, 2)
  );
  // 配列(updatedExpenses)は既にwriteFileに使われていて、関数の戻り値としては使われていません。
  return expenses.length !== updatedExpenses.length ? true : false;
  // removeは常にtrueかfalse(真偽値)を返すだけで、配列そのものを返すことはありません。
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
  /* もし、expense.idが指定されたidと一致する場合、その支出を更新するために、
   スプレッド構文を使用して既存の支出オブジェクトと変更内容をマージし、新しいオブジェクトを作成する。
   そうでない場合は、元の支出オブジェクトをそのまま返す。*/

  //該当する要素そのもの(配列ではなく)を返すのは.find()の役割です
}
