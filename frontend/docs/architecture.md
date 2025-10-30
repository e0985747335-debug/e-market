# 🏗️ e菜市 系統架構 (Architecture Overview)

本文件說明 e菜市 (e-Market) 平台的整體系統架構與主要模組關係。

---

## 🎨 高階系統架構圖

```mermaid
graph TD

subgraph UserFacing["使用者端 (前端)"]
  A1["🛒 消費者 Web / App"]
  A2["🏪 攤商後台 (Vendor Portal)"]
end

subgraph Backend["後端應用層 (API Server)"]
  B1["⚙️ REST / GraphQL API"]
  B2["🔐 Auth 認證服務"]
  B3["💳 訂單與支付模組"]
end

subgraph Database["資料與儲存"]
  C1["🗄️ PostgreSQL / MySQL"]
  C2["🖼️ 影像 / 檔案儲存 (S3, Cloudinary)"]
end

subgraph External["外部整合系統"]
  D1["💰 金流服務 (e.g. LINE Pay / 綠界)"]
  D2["🚚 物流 API (e.g. 宅配通 / 黑貓)"]
end

subgraph Admin["平台後台 (Admin Dashboard)"]
  E1["🧩 管理員登入"]
  E2["📊 數據儀表板"]
  E3["🧾 使用者 / 訂單 / 攤商管理"]
end

A1 -->|API 請求| B1
A2 -->|API 請求| B1
B1 -->|資料查詢| C1
B1 -->|圖片上傳| C2
B3 -->|串接| D1
B3 -->|串接| D2
Admin -->|內部 API| B1
模組說明
模組	說明
消費者前端	用於購物、瀏覽商品、下單與付款
攤商後台	攤商管理商品、訂單、庫存與營業資料
API Server	集中處理所有業務邏輯與資料流
資料庫	儲存商品、用戶、訂單等核心資料
外部整合	串接金流與物流，實現自動化訂單流程
平台後台	供管理員監控營運狀況與進行資料維護

🔁 開發流程
修改或新增功能 → 提交至 main 分支

GitHub Actions 自動執行 .github/workflows/vercel.yml

自動部署至 Vercel → 新版本上線

📘 作者：e-market 開發團隊
📅 文件最後更新：$(date +%Y-%m-%d)
