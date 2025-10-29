#!/bin/bash
# === 📅 e-Market 每週報告產生系統 ===
# 自動彙整 logs/*.md -> weekly/2025-WXX.md 並上傳 GitHub

PROJECT_DIR="/home/iven/e-market"
LOG_DIR="$PROJECT_DIR/logs"
REPORT_DIR="$PROJECT_DIR/weekly"
DATE_NOW=$(date +"%Y-%m-%d %H:%M:%S")
YEAR=$(date +%Y)
WEEK=$(date +%V)
REPORT_FILE="$REPORT_DIR/${YEAR}-W${WEEK}.md"

mkdir -p "$REPORT_DIR"

echo "🧾 生成週報：$REPORT_FILE"
echo "# 🗓 e-Market 開發週報 - 第 ${WEEK} 週 (${YEAR})" > "$REPORT_FILE"
echo "> 自動生成於：$DATE_NOW" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 搜尋本週所有 logs
echo "## 📅 本週每日紀錄摘要" >> "$REPORT_FILE"
grep -h "###" "$LOG_DIR"/* | tail -n 50 >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 統計提交次數
COMMITS=$(git rev-list --count HEAD)
echo "## 📊 統計資訊" >> "$REPORT_FILE"
echo "- 截至目前總提交次數：$COMMITS" >> "$REPORT_FILE"
echo "- 生成時間：$DATE_NOW" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 隨機勵志語
MOTIVATION=(
  "🔥 穩定的進步，比一時的衝刺更有力量。"
  "🌱 一週的努力，是未來成功的根。"
  "🚀 代碼會說話，堅持讓專案成長。"
  "💪 沒有小步伐的累積，就沒有大成果。"
  "🌟 下一週，繼續向更好的版本邁進。"
)
MSG=${MOTIVATION[$RANDOM % ${#MOTIVATION[@]}]}

echo "## 💡 每週感想" >> "$REPORT_FILE"
echo "- $MSG" >> "$REPORT_FILE"

# 提交與上傳
cd "$PROJECT_DIR" || exit 1
git add "$REPORT_FILE"
git commit -m "📅 自動生成週報：${YEAR}-W${WEEK}"
git push

echo ""
echo "✅ 已完成週報上傳至 GitHub！"
echo "📄 位置：$REPORT_FILE"
echo "💬 $MSG"
