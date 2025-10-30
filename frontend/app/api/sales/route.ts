// app/api/sales/route.ts
import { NextResponse } from "next/server";

export async function GET() {
  const data = [
    { month: "一月", value: 12 },
    { month: "二月", value: 19 },
    { month: "三月", value: 3 },
    { month: "四月", value: 5 },
  ];

  return NextResponse.json(data);
}
