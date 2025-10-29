"use client";

import { useEffect, useRef, useState } from "react";
import Chart from "chart.js/auto";

export default function ChartComponent() {
  const barRef = useRef<HTMLCanvasElement | null>(null);
  const pieRef = useRef<HTMLCanvasElement | null>(null);
  const [barChart, setBarChart] = useState<Chart | null>(null);
  const [pieChart, setPieChart] = useState<Chart | null>(null);

  useEffect(() => {
    if (!barRef.current || !pieRef.current) return;

    const barCtx = barRef.current.getContext("2d");
    const pieCtx = pieRef.current.getContext("2d");
    if (!barCtx || !pieCtx) return;

    const bar = new Chart(barCtx, {
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
      options: { responsive: true },
    });

    const pie = new Chart(pieCtx, {
      type: "pie",
      data: {
        labels: ["食品", "服飾", "電子", "家居"],
        datasets: [
          {
            data: [30, 20, 25, 25],
            backgroundColor: [
              "rgba(255, 99, 132, 0.6)",
              "rgba(54, 162, 235, 0.6)",
              "rgba(255, 206, 86, 0.6)",
              "rgba(75, 192, 192, 0.6)",
            ],
          },
        ],
      },
    });

    setBarChart(bar);
    setPieChart(pie);

    return () => {
      bar.destroy();
      pie.destroy();
    };
  }, []);

  // ✅ 動態更新數據
  const updateData = () => {
    if (barChart) {
      barChart.data.datasets[0].data = Array(4)
        .fill(0)
        .map(() => Math.floor(Math.random() * 30));
      barChart.update();
    }
    if (pieChart) {
      pieChart.data.datasets[0].data = Array(4)
        .fill(0)
        .map(() => Math.floor(Math.random() * 40));
      pieChart.update();
    }
  };

  return (
    <div className="space-y-8">
      <div>
        <h2 className="text-xl font-semibold mb-2">每月銷售量</h2>
        <canvas ref={barRef} width={400} height={200}></canvas>
      </div>

      <div>
        <h2 className="text-xl font-semibold mb-2">產品類別分佈</h2>
        <canvas ref={pieRef} width={400} height={200}></canvas>
      </div>

      <button
        onClick={updateData}
        className="mt-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-500"
      >
        更新資料
      </button>
    </div>
  );
}
