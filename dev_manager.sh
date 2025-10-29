#!/bin/bash
# ===================================================
# 🧩 e-Market 開發管理工具
# 功能：自動化開發日誌、排程提醒與報告產生
# ===================================================

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$PROJECT_DIR/logs"

# === [1] 顯示說明 ===
show_help() {
  echo "🧩 e-Market 開發管理工具"
  echo "使用方式： ./dev_manager.sh [指令]"
  echo ""
  echo "可用指令："
  echo "  start     - 啟動每日自動提醒與日誌更新 (cron)"
  echo "  push      - 立即建立/更新當日開發日誌並上傳 GitHub"
  echo "  remind    - 顯示今日開發提醒訊息"
  echo "  report    - 產生週報與月報摘要"
  echo "  stop      - 停用所有自動排程"
  echo "  help      - 顯示本說明"
}

# === [2] 啟動自動排程 ===
start_auto() {
  CRON_JOB="0 9 * * * bash $PROJECT_DIR/daily_reminder.sh >> $PROJECT_DIR/logs/cron.log 2>&1"
  (crontab -l 2>/dev/null | grep -v "daily_reminder.sh"; echo "$CRON_JOB") | crontab -
  echo "✅ 已設定每日早上 9:00 自動提醒與日誌更新。"
}

# === [3] 停用排程 ===
stop_auto() {
  crontab -l 2>/dev/null | grep -v "daily_reminder.sh" | crontab -
  echo "🛑 已停用所有自動排程。"
}

# === [4] 即時推送日誌到 GitHub ===
push_now() {
  mkdir -p "$LOG_DIR"
  TODAY_FILE="$LOG_DIR/$(date '+%Y-%m-%d').md"

  echo "🗓 今日日誌檢查中..."
  if [ ! -f "$TODAY_FILE" ]; then
    echo "📄 未找到今日開發日誌，正在建立..."
    echo "# 🧠 開發日誌：$(date '+%Y-%m-%d')" > "$TODAY_FILE"
    echo "建立於 $(date '+%Y-%m-%d %H:%M:%S')" >> "$TODAY_FILE"
  else
    echo "📝 已存在今日開發日誌，附加更新中..."
    echo "- 更新時間：$(date '+%Y-%m-%d %H:%M:%S')" >> "$TODAY_FILE"
  fi

  echo "🚀 提交更新至 GitHub..."
  git add -f logs/*.md
  git add -A
  git commit -m "🧠 更新 $(date '+%Y-%m-%d') 開發日誌"
  git push

  echo "✅ 已成功推送至 GitHub！"
}

# === [5] 顯示當日提醒 ===
remind_now() {
  echo "📅 $(date '+%Y-%m-%d %H:%M')"
  echo "💡 今日提醒：保持穩定進展，一次優化一小步 🚀"
}

# === [6] 產生報告 ===
generate_report() {
  echo "📊 產生週報與月報摘要中..."
  bash "$PROJECT_DIR/weekly_report.sh"
  bash "$PROJECT_DIR/monthly_report.sh"
}

# === [7] 主選單控制 ===
case "$1" in
  start)
    start_auto
    ;;
  stop)
    stop_auto
    ;;
  push)
    push_now
    ;;
  remind)
    remind_now
    ;;
  report)
    generate_report
    ;;
  help|"")
    show_help
    ;;
  *)
    echo "❌ 無效指令：$1"
    show_help
    ;;
esac
