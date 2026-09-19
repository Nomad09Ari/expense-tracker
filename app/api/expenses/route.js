import sampleExpenses from "@/data/sample";
import { getAll, create } from "@/lib/db";
import { validateExpense } from "@/lib/validation";

export async function GET() {
  //   return Response.json(sampleExpenses);
  return Response.json(await getAll());
}

export async function POST(request) {
  const body = await request.json();
  const errorValidation = validateExpense(body);
  if (errorValidation) {
    return Response.json({ error: errorValidation }, { status: 400 });
  }
  const newExpense = await create(body);
  return Response.json(newExpense, { status: 201 });
}
