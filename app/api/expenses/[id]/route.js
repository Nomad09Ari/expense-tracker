import { remove, update } from "@/lib/db";

export async function DELETE(request, { params }) {
  //paramsはrequestとは別の、第2引数({ params })から来ます。
  // bodyとは無関係で、URLの動的セグメント([id]の部分)から来る値です。
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
  /* [id]は1つの動的ルート定義であり、
  どんなid値が来ても同じroute.jsが呼ばれ、
  その都度URLから値を読み取ります。*/
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
