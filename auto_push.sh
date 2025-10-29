#!/bin/bash
set -e

# 🕒 自動加上時間戳
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "🚀 正在自動提交更新 ($timestamp)..."

# 加入所有變更
git add .

# 提交
git commit -m "🧠 自動更新：$timestamp" || echo "⚠️ 沒有新變更可提交"

# 推送到 GitHub
git push origin main

echo "✅ 已自動上傳至 GitHub！ ($timestamp)"
