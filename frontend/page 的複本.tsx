"use client";

import { useEffect, useRef } from "react";
import Chart from "chart.js/auto";

export default function DashboardPage() {
// ✅ 關鍵：明確指定泛型 HTMLCanvasElement
const chartRef = useRef<HTMLCanvasElement | null>(null);

useEffect(() => {
const canvas = chartRef.current;
if (!canvas) return; // 沒有 canvas 時不執行


const ctx = canvas.getContext("2d");
if (!ctx) return; // 沒有 context 時跳出

const chart = new Chart(ctx, {
  type: "bar",
  data: {
    labels: ["一月", "二月", "三月", "四月"],
    datasets: [
      {
        label: "銷售量",
        data: [12, 19, 3, 5],
        backgroundColor: "rgba(75, 192, 192, 0.5)",
      },
    ],
  },
  options: {
    responsive: true,
  },
});

return () => {
  chart.destroy();
};


}, []);

return ( <div className="p-8"> <h1 className="text-2xl font-bold mb-4">Dashboard</h1> <canvas ref={chartRef} width={400} height={200}></canvas> </div>
);
}
