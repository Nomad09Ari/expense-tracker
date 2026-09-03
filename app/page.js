// import { CATEGORIES, categoryLabel, formatYen } from "@/lib/categories";
import sampleExpenses from "@/data/sample";
import ExpenseList from "@/components/ExpenseList";

export default function Home() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold">支出管理</h1>
      <p className="mt-2 text-gray-600">このアプリは動いています。</p>
      <hr></hr>
      <ExpenseList expenses={sampleExpenses} />
    </main>
  );
}
