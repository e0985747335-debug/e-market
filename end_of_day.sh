#!/bin/bash
# === 🌇 e-Market 每日收工腳本 ===
# 自動附註開發完成日誌 + 上傳 GitHub + 顯示激勵語

PROJECT_DIR="/home/iven/e-market"
LOG_DIR="$PROJECT_DIR/logs"
DATE_TODAY=$(date +"%Y-%m-%d")
TIME_NOW=$(date +"%Y-%m-%d %H:%M:%S")
LOG_FILE="$LOG_DIR/$DATE_TODAY.md"

MOTIVATION=(
  "🌱 每一行程式都是一顆種子，耕耘久了就會發芽。"
  "💡 今天的堅持，是明天的成就。"
  "🚀 不用一次寫完，只要每天多一行。"
  "⚙️ 錯誤是程式的語言，解 bug 是在對話。"
  "🌇 收工不是結束，而是積累的開始。"
)

RANDOM_MSG=${MOTIVATION[$RANDOM % ${#MOTIVATION[@]}]}

cd "$PROJECT_DIR" || exit 1

echo "🕕 [$TIME_NOW] 開始自動收工流程..."

# 確保日誌存在
if [ ! -f "$LOG_FILE" ]; then
  echo "🧠 尚未建立今日開發日誌，先執行 update_log.sh..."
  bash "$PROJECT_DIR/update_log.sh"
fi

# 附加收工紀錄
echo "" >> "$LOG_FILE"
echo "### 🌇 結束開發時間：$TIME_NOW" >> "$LOG_FILE"
echo "- $RANDOM_MSG" >> "$LOG_FILE"

# 提交並上傳 GitHub
git add "$LOG_FILE"
git commit -m "🌇 收工日誌：$DATE_TODAY"
git push

echo ""
echo "✅ 今日開發日誌已更新並上傳 GitHub！"
echo "💬 $RANDOM_MSG"
echo "📄 檔案位置：$LOG_FILE"
