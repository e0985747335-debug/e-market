#!/bin/bash
# 🧠 e-Market 互動式自動開發日誌更新腳本
# 每次執行會詢問當日開發內容，並自動更新 README.md 與推送至 GitHub

DATE=$(date +"%Y/%m/%d")
TIME=$(date +"%H:%M:%S")
LINE="### $DATE $TIME"

echo "🧠 e-Market 自動開發日誌系統"
echo "---------------------------------------"
read -p "請輸入今天完成的項目或開發內容： " NOTE

if [ -z "$NOTE" ]; then
  echo "⚠️ 沒有輸入內容，已取消更新。"
  exit 0
fi

echo "🚀 新增開發日誌：$LINE"
echo "📝 內容：$NOTE"

# 在 README.md 找到 "## 🧠 開發筆記區" 後插入新的日期段落與內容
awk -v newlog="$LINE" -v note="$NOTE" '
    BEGIN {added=0}
    {
        print $0
        if ($0 ~ /^## 🧠 開發筆記區/ && added==0) {
            print ""
            print newlog
            print "- 🧩 新增：" note
            print "- 🧠 狀態：開發進行中"
            print ""
            added=1
        }
    }
' README.md > README.tmp && mv README.tmp README.md

# 提交變更並推送
git add README.md
git commit -m "Daily log update: $DATE - $NOTE"
git push

echo "✅ 已成功更新開發日誌並推送至 GitHub！"
