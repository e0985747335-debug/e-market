# 🧠 e-Market 開發筆記

> 「打造屬於本地的數位菜市場。」

這是 `e-Market` 的開發紀錄與架構說明，記錄專案的設計理念、進度與實作細節。  
目標是建立一個能讓 **消費者與生產者直接交易** 的線上平台。

---

## 🗂 專案結構

e-market/
├── backend/ # 後端 API (Node.js / Express)
│ ├── routes/ # API 路由
│ ├── models/ # 資料結構 (MongoDB Schema)
│ ├── controllers/# 控制邏輯
│ ├── config/ # 系統設定檔
│ └── server.js # 入口點
│
├── frontend/ # 前端 (React / Next.js)
│ ├── pages/ # 頁面
│ ├── components/ # 可重用元件
│ ├── store/ # 狀態管理 (Redux / Pinia)
│ └── assets/ # 靜態資源
│
├── database/ # MongoDB 設定與備份
├── docs/ # 文件與規劃筆記
└── README.md

yaml
複製程式碼

---

## 🧩 開發階段紀錄

| 日期 | 進度 | 說明 |
|------|------|------|
| 2025/10/29 | ✅ 初始化專案 | 建立 GitHub 倉庫與 SSH 部署連線 |
| 2025/10/29 | 🧱 架構規劃 | 設計前後端資料夾與技術堆疊 |
| 2025/10/30 | 🚧 待辦 | 建立 Express 後端 API |
| 2025/10/31 | 🚧 待辦 | 設定 React 前端環境與 UI 結構 |

---

## 🛠 技術堆疊

| 區塊 | 技術 | 備註 |
|------|------|------|
| 前端 | React / Next.js | 支援 RWD、模組化架構 |
| 後端 | Node.js + Express | RESTful API |
| 資料庫 | MongoDB (Mongoose ORM) | 雲端或本地連線皆可 |
| 認證 | JWT + Bcrypt | 使用者登入驗證 |
| 部署 | Ubuntu + Nginx + PM2 | 可使用 GitHub Actions 自動部署 |
| 版本控制 | Git + GitHub | 以 main 分支為主開發線 |

---
