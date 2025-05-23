#!/bin/bash

# MacBook Air Claude設定ヘルパースクリプト
# このスクリプトは MacBook Air での Claude MCP 設定を自動化します

echo "🍎 MacBook Air Claude MCP 設定ヘルパー"
echo "========================================="

# カラーコード
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ユーザー名を取得
USERNAME=$(whoami)
CLAUDE_CONFIG_DIR="/Users/$USERNAME/Library/Application Support/Claude"
CONFIG_FILE="$CLAUDE_CONFIG_DIR/claude_desktop_config.json"

echo -e "${BLUE}設定対象ユーザー: $USERNAME${NC}"
echo -e "${BLUE}Claude設定ディレクトリ: $CLAUDE_CONFIG_DIR${NC}"

# Step 1: 必要なコマンドの確認
echo -e "\n${YELLOW}Step 1: システム環境確認${NC}"

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "✅ $1 が利用可能"
        $1 --version 2>/dev/null || echo "  バージョン情報なし"
    else
        echo -e "❌ $1 が見つかりません"
        return 1
    fi
}

check_command node
check_command npm
check_command git

# Git設定確認
echo -e "\n${YELLOW}Git設定確認:${NC}"
echo "User Name: $(git config --global user.name)"
echo "User Email: $(git config --global user.email)"

# Step 2: MCPディレクトリの作成
echo -e "\n${YELLOW}Step 2: MCP作業ディレクトリ作成${NC}"
MCP_DIR="/Users/$USERNAME/Desktop/mcp"
mkdir -p "$MCP_DIR"
echo -e "✅ ディレクトリ作成: $MCP_DIR"

# Step 3: GitHub MCP インストール
echo -e "\n${YELLOW}Step 3: GitHub MCP インストール${NC}"
echo "GitHub MCP サーバーをインストールします..."
npm install -g @modelcontextprotocol/server-github
if [ $? -eq 0 ]; then
    echo -e "✅ GitHub MCP インストール完了"
else
    echo -e "❌ GitHub MCP インストールに失敗"
fi

# Step 4: Claude設定ディレクトリの確認
echo -e "\n${YELLOW}Step 4: Claude設定ディレクトリ確認${NC}"
if [ -d "$CLAUDE_CONFIG_DIR" ]; then
    echo -e "✅ Claude設定ディレクトリが存在"
    ls -la "$CLAUDE_CONFIG_DIR" | head -10
else
    echo -e "❌ Claude設定ディレクトリが見つかりません"
    echo "Claude Desktopアプリがインストールされているか確認してください"
fi

# Step 5: 設定ファイルのバックアップ
echo -e "\n${YELLOW}Step 5: 設定ファイルバックアップ${NC}"
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "✅ 既存設定ファイルをバックアップしました"
else
    echo -e "ℹ️  新規設定ファイルを作成します"
fi

# Step 6: 設定ファイルテンプレート作成
echo -e "\n${YELLOW}Step 6: 設定ファイルテンプレート作成${NC}"

# GitHubトークンの入力
echo -e "${BLUE}GitHub Personal Access Tokenを入力してください:${NC}"
echo -e "${RED}注意: トークンは画面に表示されません${NC}"
read -s GITHUB_TOKEN

if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "❌ トークンが入力されませんでした"
    exit 1
fi

# 設定ファイル作成
cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/"
      ]
    },
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "$GITHUB_TOKEN"
      }
    }
  }
}
EOF

echo -e "✅ Claude設定ファイルを作成しました"

# Step 7: 完了メッセージ
echo -e "\n${GREEN}🎉 設定完了！${NC}"
echo -e "${YELLOW}次の手順:${NC}"
echo "1. Claude Desktopアプリを完全に終了 (Command + Q)"
echo "2. Claude Desktopアプリを再起動"
echo "3. 以下のメッセージでテスト:"
echo -e "   ${BLUE}「GitHub MCP と Desktop Commander MCP の動作確認をお願いします」${NC}"

echo -e "\n${YELLOW}Desktop Commander MCP について:${NC}"
echo "Desktop Commander MCP は別途設定が必要です"
echo "詳細は docs/setup-instructions-macbook-air.md を参照してください"

echo -e "\n${YELLOW}設定ファイル場所:${NC}"
echo "$CONFIG_FILE"
