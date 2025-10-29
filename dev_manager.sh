#!/bin/bash
# ============================================
# 🧩 e-Market 開發管理工具 (v2.0)
# 功能：集中管理日誌、提醒、自動排程、Git 推送
# ============================================

PROJECT_DIR="$HOME/e-market"
LOG_DIR="$PROJECT_DIR/logs"
SCRIPT_NAME="dev_manager.sh"

# === 顯示說明 ===
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

# === 自動化啟動 ===
start_auto() {
  echo "⏰ 啟動每日自動任務..."
  (crontab -l 2>/dev/null; echo "0 9 * * * $PROJECT_DIR/daily_reminder.sh") | crontab -
  echo "✅ 已設定每日 09:00 自動提醒與日誌更新！"
}

# === 停止所有自動化 ===
stop_auto() {
  echo "🛑 停用所有 e-Market 自動任務..."
  crontab -l | grep -v "e-market" | crontab -
  echo "✅ 已清除相關排程。"
}

# === 今日提醒 ===
remind_now() {
  echo "📅 $(date '+%Y-%m-%d %H:%M:%S')"
  echo "🚀 開工愉快！記得更新開發日誌 🌱"
}

# === Push 日誌（包含被忽略的 logs） ===
push_now() {
  echo "🗓 今日日誌檢查中..."

  TODAY_LOG="$LOG_DIR/$(date '+%Y-%m-%d').md"

  if [ -f "$TODAY_LOG" ]; then
    echo "📝 已存在今日開發日誌，附加更新中..."
    echo "- $(date '+%H:%M:%S') 自動附加更新" >> "$TODAY_LOG"
  else
    echo "🆕 建立新開發日誌：$TODAY_LOG"
    mkdir -p "$LOG_DIR"
    echo "# 開發日誌 $(date '+%Y-%m-%d')" > "$TODAY_LOG"
    echo "- 建立時間：$(date '+%H:%M:%S')" >> "$TODAY_LOG"
  fi

  echo "🚀 提交更新至 GitHub..."
  git add -f logs/*.md
  git add -A
  git commit -m "🧠 更新 $(date '+%Y-%m-%d') 開發日誌"
  git push
  echo "✅ 已成功推送至 GitHub！"
}

# === 產生報告 ===
generate_report() {
  echo "📊 產生報告中..."
  bash "$PROJECT_DIR/weekly_report.sh"
  bash "$PROJECT_DIR/monthly_report.sh"
}

# === 主指令入口 ===
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
    echo "❌ 未知指令：$1"
    show_help
    ;;
esac

