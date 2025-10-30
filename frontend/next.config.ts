import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  turbopack: {}, // ✅ 開啟 Turbopack 模式
  reactCompiler: false, // ✅ 關閉 React Compiler
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
