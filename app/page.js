"use client";
import { useState } from "react";
import sampleExpenses from "@/data/sample";
import ExpenseList from "@/components/ExpenseList";
import ExpenseForm from "@/components/ExpenseForm";

export default function Home() {
  const [expenses, setExpenses] = useState(sampleExpenses);
  const handleAdd = (newExpense) => {
    setExpenses((prevExpenses) => [...prevExpenses, newExpense]);
  };
  const handleDelete = (id) => {
    setExpenses((prevExpenses) =>
      prevExpenses.filter((expense) => expense.id !== id)
    );
  };
  return (
    <main className="mx-auto max-w-2xl p-8">
      <h1 className="text-3xl font-bold">支出管理</h1>
      <p className="mt-2 text-gray-600">このアプリは動いています。</p>
      <hr className="my-6 border-gray-200" />
      <div className="space-y-8">
        <ExpenseList expenses={expenses} onDelete={handleDelete} />
        <ExpenseForm onAdd={handleAdd} />
      </div>
    </main>
  );
}
