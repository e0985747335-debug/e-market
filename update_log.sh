#!/bin/bash
set -e

# === 1️⃣ 生成今日日期 ===
today=$(date +"%Y-%m-%d")
log_dir="logs"
log_file="$log_dir/$today.md"

# === 2️⃣ 準備資料夾 ===
mkdir -p "$log_dir"

# === 3️⃣ 若當日檔案不存在則建立 ===
if [ ! -f "$log_file" ]; then
  echo "🧠 建立開發日誌：$log_file"
  cat > "$log_file" << EOL
# 📅 開發日誌 — $today

## 🧩 今日進度
- [ ] 新功能開發
- [ ] Bug 修復
- [ ] UI 改善
- [ ] 文件更新

## 💭 備註
> 自動建立於 $(date +"%Y/%m/%d %H:%M:%S")。
EOL
else
  echo "🗓 今日日誌已存在，附加更新記錄..."
  echo "- 更新於 $(date +"%H:%M:%S")" >> "$log_file"
fi

# === 4️⃣ 自動提交至 Git ===
echo "🚀 提交更新至 GitHub..."
git add "$log_file"
git commit -m "🧠 每日開發日誌更新：$today" || echo "⚠️ 無需提交（無變更）"
git push origin main

echo "✅ 已完成開發日誌記錄並上傳 GitHub！"
