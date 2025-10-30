# 建 docs 資料夾（若已存在不會錯）
mkdir -p docs

# 建檔並寫入內容（heredoc）
cat > docs/architecture.md << 'EOF'
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
