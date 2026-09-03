import ExpenseItem from "@/components/ExpenseItem";

export default function ExpenseList({ expenses }) {
  return (
    <div>
      {expenses.map((expense) => (
        <ExpenseItem
          amount={expense.amount}
          category={expense.category}
          note={expense.note}
          date={expense.date}
          key={expense.id}
        />
      ))}
    </div>
  );
}
