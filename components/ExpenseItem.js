import { categoryLabel, formatYen } from "@/lib/categories";

export default function ExpenseItem({ amount, category, note, date }) {
  return (
    <div>
      <div>
        <div>{note}</div>
        <div>{date}</div>
      </div>
      <div>
        <span>{formatYen(amount)}</span>
        <span>{categoryLabel(category)}</span>
      </div>
    </div>
  );
}
