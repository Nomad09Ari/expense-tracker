export const CATEGORIES = [
  { value: "food", label: "食費", emoji: "🍜" },
  { value: "transport", label: "交通費", emoji: "🚌" },
  { value: "other", label: "その他", emoji: "📦" },
];

export function categoryLabel(value) {
  return CATEGORIES.find((c) => c.value === value)?.label ?? value;
}

const yen = new Intl.NumberFormat("ja-JP", {
  style: "currency",
  currency: "JPY",
  maximumFractionDigits: 0,
});

export function formatYen(amount) {
  return yen.format(amount);
}
