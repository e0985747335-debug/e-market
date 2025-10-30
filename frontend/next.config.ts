import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // ✅ 不使用實驗選項
  reactCompiler: false,

  // ✅ 新增 turbopack 空設定（解決錯誤）
  turbopack: {},

  // ✅ 圖片設定照舊
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "**",
      },
    ],
  },
};

export default nextConfig;
