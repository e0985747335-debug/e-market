import type { NextConfig } from "next";

const nextConfig: NextConfig = {
experimental: {
reactCompiler: false,
turbo: false, // 🚫 明確關掉 Turbopack
},
webpack: (config) => {
// ✅ 強制啟用 Webpack
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
