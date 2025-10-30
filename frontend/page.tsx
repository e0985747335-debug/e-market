"use client";

import { useEffect, useRef } from "react";
import Chart from "chart.js/auto";

export default function DashboardPage() {
  const chartRef = useRef<HTMLCanvasElement | null>(null);
  const chartInstance = useRef<Chart | null>(null);

  useEffect(() => {
    async function loadChartData() {
      try {
        console.log("🔍 正在載入 /api/sales...");
        const res = await fetch("/api/sales", { cache: "no-store" });
        console.log("🛰️ Response status:", res.status);

        if (!res.ok) throw new Error("無法載入銷售資料");
        const data = await res.json();
        console.log("✅ 收到資料:", data);

        const labels = data.map((d: any) => d.month);
        const values = data.map((d: any) => d.value);

        console.log("📊 Labels:", labels);
        console.log("📈 Values:", values);

        // 銷毀舊圖表避免重繪錯誤
        if (chartInstance.current) {
          console.log("🧹 銷毀舊圖表");
          chartInstance.current.destroy();
        }

        const canvas = chartRef.current;
        if (!canvas) {
          console.warn("⚠️ 找不到 canvas 元素");
          return;
        }

        const ctx = canvas.getContext("2d");
        if (!ctx) {
          console.warn("⚠️ 無法取得 2D context");
          return;
        }

        console.log("🎨 開始建立 Chart.js 圖表");
        chartInstance.current = new Chart(ctx, {
          type: "bar",
          data: {
            labels,
            datasets: [
              {
                label: "銷售量",
                data: values,
                backgroundColor: "rgba(75,192,192,0.6)",
              },
            ],
          },
          options: {
            responsive: true,
            scales: {
              y: {
                beginAtZero: true,
              },
            },
          },
        });
        console.log("✅ 圖表建立完成");
      } catch (err) {
        console.error("❌ 發生錯誤：", err);
      }
    }

    loadChartData();
  }, []);

  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold mb-4">Dashboard</h1>
      <canvas ref={chartRef} width={600} height={300}></canvas>
    </div>
  );
}
