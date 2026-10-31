"use client";
import { useState, useEffect } from "react";
import ExpenseList from "@/components/ExpenseList";
import ExpenseForm from "@/components/ExpenseForm";
import { useToast } from "@/components/Toast";
import ToastHost from "@/components/ToastHost";
import { getExpenses, createExpense, deleteExpense } from "@/lib/api";

export default function Home() {
  const [expenses, setExpenses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [isSaving, setIsSaving] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  const { toast, show } = useToast();

  useEffect(() => {
    load();
  }, []);

  async function load() {
    try {
      const data = await getExpenses();
      setExpenses(data);
      setError(null);
    } catch (e) {
      setError(`${e.message}, エラーが出ました！`);
    } finally {
      setLoading(false);
    }
  }

  async function handleAdd(newExpense) {
    setIsSaving(true);
    try {
      await createExpense(newExpense);

      await load();
      show("追加に成功しました。", "success");
    } catch (e) {
      console.error(e);
      show(e.message || "追加に失敗しました。", "error");
    } finally {
      setIsSaving(false);
    }
  }

  async function handleDelete(id) {
    setIsDeleting(true);
    try {
      await deleteExpense(id);

      await load();
      show("削除に成功しました。", "success");
    } catch (e) {
      console.error(e);
      show(e.message || "削除に失敗しました。", "error");
    } finally {
      setIsDeleting(false);
    }
  }

  //エラーの場合に再読込するための関数
  function handleReload() {
    setLoading(true);
    load();
  }

  let content;

  if (loading) {
    content = <p>読み込み中...</p>;
  } else if (error) {
    content = (
      <div>
        <p>{error}</p>
        <button
          onClick={handleReload}
          className="mt-4 rounded bg-gray-900 px-4 py-2 text-white hover:bg-gray-700"
        >
          再読み込み
        </button>
      </div>
    );
  } else {
    content = (
      <div className="space-y-8">
        <ExpenseList
          expenses={expenses}
          onDelete={handleDelete}
          isDeleting={isDeleting}
        />
        <ExpenseForm onAdd={handleAdd} isSaving={isSaving} />
      </div>
    );
  }

  return (
    <main className="mx-auto max-w-2xl p-8">
      <h1 className="text-3xl font-bold">支出管理</h1>
      <p className="mt-2 text-gray-600">このアプリは動いています。</p>
      <hr className="my-6 border-gray-200" />
      {content}
      <ToastHost toast={toast} />
    </main>
  );
}
