import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  turbopack: {}, // ✅ 新版 Next.js 16 預設使用 Turbopack
  reactCompiler: false, // ✅ 關閉 React Compiler（原本在 experimental.reactCompiler）
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
