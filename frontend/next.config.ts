import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // ✅ 明確使用 Turbopack，解決錯誤
  turbopack: {},

  // ✅ 移除 webpack 舊設定（Next.js 16 不需要）
  // webpack: (config) => config,

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
