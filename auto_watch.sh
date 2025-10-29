#!/bin/bash
# === 🔔 e-Market 自動監控與提醒系統 ===

PROJECT_DIR="/home/iven/e-market"
DASHBOARD="$PROJECT_DIR/status_dashboard.sh"
LOG_FILE="$PROJECT_DIR/.watch_log"
INTERVAL=30  # 每 30 秒檢查一次

# 顏色設定
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${CYAN}🔍 啟動 e-Market 專案自動監控中...${RESET}"
echo -e "📂 監控路徑：${YELLOW}$PROJECT_DIR${RESET}"
echo -e "⏱ 監測頻率：每 ${INTERVAL} 秒"
echo ""

# 初始快照
SNAPSHOT=$(find "$PROJECT_DIR" -type f ! -path "*/node_modules/*" -exec md5sum {} + 2>/dev/null)

while true; do
  sleep "$INTERVAL"
  NEW_SNAPSHOT=$(find "$PROJECT_DIR" -type f ! -path "*/node_modules/*" -exec md5sum {} + 2>/dev/null)

  # 比對變更
  if [ "$NEW_SNAPSHOT" != "$SNAPSHOT" ]; then
    echo -e "${YELLOW}⚡ 偵測到檔案變更，開啟儀表板！${RESET}"
    SNAPSHOT="$NEW_SNAPSHOT"

    # 寫入日誌
    echo "$(date '+%Y-%m-%d %H:%M:%S') — 偵測到變更" >> "$LOG_FILE"

    # 終端提示
    notify-send "🧠 e-Market" "偵測到專案變更，開啟狀態儀表板！"

    # 自動開啟 dashboard
    bash "$DASHBOARD"
  fi
done
