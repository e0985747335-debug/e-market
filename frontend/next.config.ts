import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // ✅ 將 reactCompiler 移出 experimental
  reactCompiler: false, // 如果不使用 React Compiler，就設為 false

  webpack: (config) => {
    // ✅ 使用 Webpack 而不是 Turbopack
    return config;
  },

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
