#!/bin/bash

# ==========================================================

# 🧠 e-Market 開發管理工具 (Smart Push 版)

# 自動建立/更新日誌、推送 GitHub、排程提醒、產生報告

# ==========================================================

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$PROJECT_DIR/logs"
TODAY="$(date '+%Y-%m-%d')"
TODAY_LOG="$LOG_DIR/$TODAY.md"

# --- Function: 顯示說明 ---

show_help() {
echo "🧩 e-Market 開發管理工具 (Smart Push 版)"
echo "使用方式： ./dev_manager.sh [指令]"
echo ""
echo "可用指令："
echo "  start     - 啟動每日自動提醒與日誌更新 (cron)"
echo "  stop      - 停用自動排程"
echo "  push      - 智慧檢查並自動推送 GitHub"
echo "  remind    - 顯示今日開發提醒訊息"
echo "  report    - 產生週報與月報摘要"
echo "  help      - 顯示此說明"
}

# --- Function: 智慧推送 ---

smart_push() {
echo "🧠 檢查日誌狀態..."
mkdir -p "$LOG_DIR"

if [ ! -f "$TODAY_LOG" ]; then
echo "📝 建立今日開發日誌：$TODAY_LOG"
echo "### $TODAY" > "$TODAY_LOG"
echo "- 建立初始開發記錄於 $(date '+%H:%M:%S')" >> "$TODAY_LOG"
else
echo "🗓 已存在今日開發日誌，附加更新..."
echo "- 自動附加更新於 $(date '+%H:%M:%S')" >> "$TODAY_LOG"
fi

echo "🧩 檢查 Git 變更..."
CHANGES=$(git status --porcelain)

if [ -z "$CHANGES" ]; then
echo "✅ 無檔案變更，略過提交與推送。"
echo "- [$(date '+%H:%M:%S')] 無變更，略過推送。" >> "$TODAY_LOG"
else
echo "🚀 偵測到變更，開始推送..."
git add -f logs/*.md
git add -A
git commit -m "🧠 智慧推送：更新 $TODAY 開發日誌"
git push
echo "✅ 已推送至 GitHub！"
echo "- [$(date '+%H:%M:%S')] 已推送更新。" >> "$TODAY_LOG"
fi
}

# --- Function: 啟動排程 ---

start_auto() {
(crontab -l 2>/dev/null | grep -v "$PROJECT_DIR/dev_manager.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 9 * * * $PROJECT_DIR/dev_manager.sh remind") | crontab -
echo "🕒 已啟動每日 09:00 自動提醒與日誌檢查。"
}

# --- Function: 停用排程 ---

stop_auto() {
crontab -l 2>/dev/null | grep -v "$PROJECT_DIR/dev_manager.sh" | crontab -
echo "🛑 已停用所有自動排程。"
}

# --- Function: 提醒訊息 ---

remind_now() {
echo "📅 $(date '+%Y-%m-%d %H:%M')"
echo "💡 今日開發日誌路徑：$TODAY_LOG"
echo "🚀 開工愉快 — 程式像農作，慢耕慢收 🌱"
}

# --- Function: 產生報告 ---

generate_report() {
echo "🧾 產生週報與月報..."
bash "$PROJECT_DIR/weekly_report.sh"
bash "$PROJECT_DIR/monthly_report.sh"
}

# --- 指令處理 ---

case "$1" in
start) start_auto ;;
stop) stop_auto ;;
push) smart_push ;;
remind) remind_now ;;
report) generate_report ;;
help|"") show_help ;;
*) echo "❌ 未知指令：$1"; show_help ;;
esac
