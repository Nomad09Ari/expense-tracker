import { remove, update } from "@/lib/db";
import { validateExpense } from "@/lib/validation";

export async function DELETE(request, { params }) {
  const { id } = await params;
  const isDeleted = await remove(id);
  if (isDeleted) {
    return Response.json({ message: "支出が削除されました" }, { status: 200 });
  } else {
    return Response.json(
      { message: "支出が見つかりませんでした" },
      { status: 404 }
    );
  }
}

export async function PATCH(request, { params }) {
  const { id } = await params;
  const body = await request.json();
  const updatedExpense = await update(id, body);
  if (!updatedExpense) {
    return Response.json(
      { message: "支出が見つかりませんでした" },
      { status: 404 }
    );
  }
  return Response.json(updatedExpense, { status: 200 });
}
