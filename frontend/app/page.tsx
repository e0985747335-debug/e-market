import Link from "next/link";

export default function Home() {
  return (
    <div className="text-center mt-16">
      <h1 className="text-4xl font-bold">歡迎來到 🧠 e-Market</h1>
      <p className="text-gray-600 mt-4">打造屬於本地的數位菜市場 — 讓消費者與生產者直接交易。</p>
      <Link href="/market" className="inline-block mt-6 bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition">
        進入市集
      </Link>
    </div>
  );
}
