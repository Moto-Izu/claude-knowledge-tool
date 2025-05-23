# MacBook Air Claude設定作業指示書

## 📋 概要
自宅のMacBook Air Claude Desktop アプリにGitHub MCPとDesktop Commander MCPを設定するための詳細な作業手順です。

## 🎯 目標
- Desktop Commander MCP の導入・設定
- GitHub MCP の導入・設定  
- 知的ツール開発環境の構築
- メインMac（現在の環境）との連携確立

## 📝 事前準備

### 必要な情報
- **GitHub Personal Access Token**: `[別途secure channelで共有]`
- **GitHub Username**: `Moto-Izu` (GitのユーザーID: `Rentan55`)
- **Email**: `changethewind2015@gmail.com`

## 🔧 作業手順

### Step 1: システム環境の確認

```bash
# Node.js/npmの確認
which node
which npm
node --version
npm --version

# Gitの設定確認
git config --global user.name
git config --global user.email

# 必要に応じてGit設定
git config --global user.name "Rentan55"
git config --global user.email "changethewind2015@gmail.com"
```

### Step 2: Desktop Commander MCP の導入

```bash
# 作業ディレクトリの作成
mkdir -p ~/Desktop/mcp
cd ~/Desktop/mcp

# Desktop Commander MCP のクローン（または直接ダウンロード）
# GitHub から最新版を取得する必要があります
# 具体的なリポジトリURLは後で確認

# 依存関係のインストール
npm install

# ビルド
npm run build
```

### Step 3: GitHub MCP の導入

```bash
# GitHub MCP サーバーのインストール
npm install -g @modelcontextprotocol/server-github
```

### Step 4: Claude Desktop 設定ファイルの更新

#### 設定ファイルの場所
```
/Users/[ユーザー名]/Library/Application Support/Claude/claude_desktop_config.json
```

#### 設定ファイルの構造

```json
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
    "desktop-commander": {
      "command": "node",
      "args": [
        "/Users/[ユーザー名]/Desktop/mcp/DesktopCommanderMCP/dist/index.js"
      ]
    },
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "[トークンをここに設定]"
      }
    }
  }
}
```

**⚠️ 重要**: 
- `[ユーザー名]` を実際のユーザー名に置き換え
- `[トークンをここに設定]` に実際のGitHubトークンを設定

### Step 5: 設定ファイル更新の実行

```bash
# バックアップ作成
cp "/Users/$(whoami)/Library/Application Support/Claude/claude_desktop_config.json" "/Users/$(whoami)/Library/Application Support/Claude/claude_desktop_config.json.bak"

# 設定ファイルを手動で編集するか、以下のテンプレートを使用
# セキュリティ上、トークンは別途設定してください
```

### Step 6: Claude Desktop アプリの再起動

1. **Claude Desktop アプリを完全に終了**
   - Command + Q で終了
   - アクティビティモニターで完全に停止していることを確認

2. **Claude Desktop アプリを再起動**

### Step 7: 動作確認

Claude Desktop アプリ再起動後、以下をテストしてください：

#### Desktop Commander MCP テスト
```
Desktop Commander MCPの動作確認をお願いします
```

#### GitHub MCP テスト  
```
GitHubリポジトリ claude-knowledge-tool の内容を確認してください
```

## 📋 チェックリスト

- [ ] Node.js/npm の動作確認
- [ ] Git 設定の確認
- [ ] Desktop Commander MCP のインストール
- [ ] GitHub MCP のインストール
- [ ] 設定ファイルの更新
- [ ] Claude Desktop の再起動
- [ ] Desktop Commander MCP の動作確認
- [ ] GitHub MCP の動作確認
- [ ] claude-knowledge-tool リポジトリへのアクセス確認

## 🚨 トラブルシューティング

### よくある問題

1. **権限エラー**
   ```bash
   sudo chown -R $(whoami) ~/Desktop/mcp
   ```

2. **NPMパッケージエラー**
   ```bash
   npm cache clean --force
   npm install
   ```

3. **設定ファイルパス間違い**
   ```bash
   ls -la "/Users/$(whoami)/Library/Application Support/Claude/"
   ```

### デバッグ用コマンド

```bash
# Claude設定ディレクトリの確認
ls -la "/Users/$(whoami)/Library/Application Support/Claude/"

# 設定ファイルの内容確認
cat "/Users/$(whoami)/Library/Application Support/Claude/claude_desktop_config.json"

# Desktop Commander MCP の存在確認
ls -la "/Users/$(whoami)/Desktop/mcp/DesktopCommanderMCP/dist/"
```

## 📞 サポート

問題が発生した場合は、メインMac（現在の環境）のClaudeに以下を伝えてください：

1. **実行したステップ**
2. **エラーメッセージ（あれば）**
3. **システム環境情報**

## 🔐 セキュリティ注意事項

- GitHub Personal Access Tokenは機密情報です
- 設定ファイルをGitリポジトリにコミットしないよう注意
- トークンは定期的に更新することを推奨

## 🎉 完了後の次ステップ

設定完了後は、知的ツールの開発を両方のMacで並行して進めることができます：

- **メインMac**: 主要開発・設計
- **MacBook Air**: テスト・検証・サブ開発

## 📱 追加のMCP設定（オプション）

必要に応じて以下のMCPも追加可能：

- **Apple MCP**: Contacts, Notes, Messages, Mail, Calendar連携
- **Browser MCP**: ウェブブラウザ自動化
- **Blender MCP**: 3Dモデリング連携

---

**作成日**: 2025年5月24日  
**作成者**: Claude (メインMac環境)  
**対象**: MacBook Air Claude Desktop App

## 📋 完了確認

設定完了後、以下のメッセージをMacBook Air のClaudeに送信してください：

```
セットアップ完了しました。GitHub MCP とDesktop Commander MCP の動作確認をお願いします。claude-knowledge-toolリポジトリにアクセスできるかも確認してください。
```
