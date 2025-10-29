export default function Home() {
  return (
    <main className="flex flex-col items-center justify-center min-h-[80vh] text-center">
      <div className="flex flex-col items-center space-y-6">
        <h1 className="text-5xl font-extrabold text-green-700">e-Market</h1>
        <h2 className="text-2xl text-gray-700">打造屬於本地的數位菜市場</h2>
        <p className="text-gray-600 max-w-md leading-relaxed">
          讓 <span className="font-medium text-green-600">消費者</span> 與{" "}
          <span className="font-medium text-green-600">生產者</span> 能直接交易，
          讓新鮮食材離你更近。
        </p>

        <div className="flex space-x-4 mt-4">
          <a
            href="#"
            className="px-6 py-3 bg-green-600 text-white rounded-xl shadow hover:bg-green-700 transition"
          >
            進入市集
          </a>
          <a
            href="#"
            className="px-6 py-3 bg-white border border-green-500 text-green-600 rounded-xl hover:bg-green-50 transition"
          >
            關於我們
          </a>
        </div>
      </div>
    </main>
  );
}
