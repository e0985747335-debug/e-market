"use client";

import { useEffect, useRef } from "react";
import Chart from "chart.js/auto";

export default function DashboardPage() {
  const chartRef = useRef<HTMLCanvasElement | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      const res = await fetch("/api/sales");
      const data = await res.json();

      if (!chartRef.current) return;
      const ctx = chartRef.current.getContext("2d");
      if (!ctx) return;

      new Chart(ctx, {
        type: "bar",
        data: {
          labels: data.labels,
          datasets: [
            {
              label: "Sales",
              data: data.values,
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
      <canvas ref={chartRef} />
    </div>
  );
}
