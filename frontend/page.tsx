"use client";

import { useEffect, useRef } from "react";
import Chart from "chart.js/auto";

export default function DashboardPage() {
  // ✅ 明確指定 useRef 型別
  const chartRef = useRef<HTMLCanvasElement | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      const res = await fetch("/api/sales");
      const data = await res.json();

      // ✅ 確保 ref 存在
      if (!chartRef.current) return;

      // ✅ 使用 non-null 斷言 !
      const ctx = chartRef.current!.getContext("2d");
      if (!ctx) return;

      new Chart(ctx, {
        type: "bar",
        data: {
          labels: data.map((item: any) => item.month),
          datasets: [
            {
              label: "Sales",
              data: data.map((item: any) => item.value),
              backgroundColor: "rgba(75, 192, 192, 0.5)",
            },
          ],
        },
      });
    };

    fetchData();
  }, []);

  return (
    <div className="p-4">
      <h1 className="text-xl font-bold mb-4">Dashboard</h1>
      <canvas ref={chartRef} width={400} height={200}></canvas>
    </div>
  );
}
