#!/usr/bin/bash

# 1. 錯誤檢查：任何命令失敗即退出，使用未定義變數即退出
set -e
set -u

# 2. 檢查 wp-cli 是否存在
if ! command -v wp &> /dev/null
then
    echo "錯誤：wp-cli (wp 命令) 未安裝或不在 PATH 中。"
    exit 1
fi

# 3. 外掛列表 (易於維護)
PLUGINS=(
    "all-in-one-seo-pack"
    "all-in-one-wp-migration"
    "all-in-one-wp-security-and-firewall"
    "amp"
    "elementor"
    "google-analytics-for-wordpress"
    "smart-slider-3"
    "simple-tags"
    "url-shortify"
    "w3-total-cache"
    "wp-mail-smtp"
    "wpforms-lite"
    "health-endpoint"
)
# 4. 安裝所有外掛 (使用迴圈，更簡潔)
echo "--- 開始安裝並啟用 ${#PLUGINS[@]} 個外掛 ---"
for PLUGIN in "${PLUGINS[@]}"; do
    wp plugin install "$PLUGIN" --activate --allow-root
done
echo "外掛安裝完成！"

# 5. 安裝佈景主題
THEMES=(
    "astra"
)

for THEME in "${THEMES[@]}"; do
    echo "--- 開始安裝並啟用佈景主題：$THEME ---"
    wp plugin install "$THEME" --activate --allow-root
done
echo "佈景主題安裝完成！"
