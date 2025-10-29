#!/bin/bash
set -e

# === 移動到專案目錄 ===
cd ~/e-market

echo "🧠 [$(date +"%Y-%m-%d %H:%M:%S")] e-Market 開發日誌自動任務啟動中..."

# === 執行開發日誌腳本 ===
./update_log.sh

# === 顯示成功訊息 ===
echo ""
echo "📅 $(date +"%Y-%m-%d %H:%M:%S")"
echo "✅ 今日開發日誌已建立並上傳至 GitHub！"
echo "💡 檔案位置：logs/$(date +"%Y-%m-%d").md"
echo "🚀 開工愉快，程式像農作 — 慢耕慢收 🌱"

# === 桌面通知 (若支援 GUI) ===
if command -v notify-send >/dev/null 2>&1; then
  notify-send "🧠 e-Market 開發提醒" "✅ 今日開發日誌已更新並上傳 GitHub！\n🚀 開工愉快 🌱"
fi

# === 寫入每日 log ===
echo "[$(date +"%Y-%m-%d %H:%M:%S")] 自動任務完成 ✅" >> ~/e-market/logs/cron.log
