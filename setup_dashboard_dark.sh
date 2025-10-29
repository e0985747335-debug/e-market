#!/bin/bash
set -e

echo "🌙 建立深色風格 Dashboard 頁面與 Mock API..."

# === Step 1. 準備資料夾 ===
mkdir -p frontend/app/dashboard
mkdir -p frontend/app/api/mock-api

# === Step 2. 建立 dashboard/page.tsx ===
cat > frontend/app/dashboard/page.tsx <<'EOF'
'use client';

import { useEffect, useRef } from 'react';
import Chart from 'chart.js/auto';

export default function DashboardPage() {
  const chartRef = useRef(null);

  useEffect(() => {
    if (!chartRef.current) return;

    const ctx = chartRef.current.getContext('2d');

    const chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['UI/UX', 'Logistics', 'Product', 'Marketing'],
        datasets: [
          {
            label: '優化進度 (%)',
            data: [85, 70, 60, 50],
            backgroundColor: [
              '#06D6A0',
              '#118AB2',
              '#FFD166',
              '#EF476F'
            ],
            borderRadius: 8,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            labels: {
              color: '#E5E7EB'
            }
          },
          title: {
            display: true,
            text: '📊 儀表板（深色模式）',
            color: '#F3F4F6',
            font: { size: 20 }
          }
        },
        scales: {
          x: {
            ticks: { color: '#9CA3AF' },
            grid: { color: '#374151' }
          },
          y: {
            ticks: { color: '#9CA3AF' },
            grid: { color: '#4B5563' }
          }
        }
      }
    });

    return () => chart.destroy();
  }, []);

  return (
    <main className="min-h-screen bg-gray-900 text-gray-100 p-10">
      <h1 className="text-3xl font-bold mb-6 text-center">e-Market 深色儀表板</h1>
      <div className="max-w-3xl mx-auto bg-gray-800 rounded-xl shadow-lg p-6">
        <canvas ref={chartRef} height="200"></canvas>
      </div>
    </main>
  );
}
EOF

# === Step 3. 建立 API mock route ===
cat > frontend/app/api/mock-api/route.ts <<'EOF'
import { NextResponse } from 'next/server';

export async function GET() {
  const data = {
    uiux: 85,
    logistics: 70,
    product: 60,
    marketing: 50,
  };
  return NextResponse.json(data);
}
EOF

# === Step 4. Git Commit + Push ===
git add frontend/app/dashboard/page.tsx frontend/app/api/mock-api/route.ts
git commit -m "🌙 新增深色模式 Dashboard 與 mock API"
git push

echo "✅ 已完成深色模式 Dashboard 建立並上傳 GitHub！"

