#!/bin/bash
# === 🌕 e-Market 每月總結報告系統 ===
# 自動彙整 weekly/*.md 成 monthly/YYYY-MM.md，並上傳 GitHub

PROJECT_DIR="/home/iven/e-market"
WEEKLY_DIR="$PROJECT_DIR/weekly"
MONTHLY_DIR="$PROJECT_DIR/monthly"

YEAR=$(date +%Y)
MONTH=$(date +%m)
DATE_NOW=$(date +"%Y-%m-%d %H:%M:%S")
REPORT_FILE="$MONTHLY_DIR/${YEAR}-${MONTH}.md"

mkdir -p "$MONTHLY_DIR"

echo "🧾 生成月報：$REPORT_FILE"
echo "# 🌕 e-Market 開發月報 - ${YEAR}年${MONTH}月" > "$REPORT_FILE"
echo "> 自動生成於：$DATE_NOW" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "## 📅 本月週報摘要" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 找出本月的所有週報
grep -h "^# 🗓" "$WEEKLY_DIR"/${YEAR}-W*.md 2>/dev/null >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 合併內容
echo "## 📖 詳細內容彙整" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
cat "$WEEKLY_DIR"/${YEAR}-W*.md 2>/dev/null >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 隨機激勵語
MOTIVATION=(
  "🌟 穩定輸出是開發者最強的力量。"
  "🚀 小步快跑，積累成長。"
  "🌱 一個月的堅持，就是進步的印記。"
  "💡 專案是一場長跑，別忘了欣賞沿途風景。"
  "🔥 程式的節奏，就是你的節奏。"
)
MSG=${MOTIVATION[$RANDOM % ${#MOTIVATION[@]}]}

echo "## 💬 本月感想" >> "$REPORT_FILE"
echo "- $MSG" >> "$REPORT_FILE"

# 提交與上傳
cd "$PROJECT_DIR" || exit 1
git add "$REPORT_FILE"
git commit -m "🌕 自動生成月報：${YEAR}-${MONTH}"
git push

echo ""
echo "✅ 已完成月報上傳至 GitHub！"
echo "📄 檔案位置：$REPORT_FILE"
echo "💬 $MSG"
