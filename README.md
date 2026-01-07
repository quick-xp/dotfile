# dotfiles

モダンな開発環境の設定ファイル集。

## 構成

```
dotfile/
├── .zshrc          # Zsh 設定 (Oh My Zsh + Powerlevel10k)
├── .tmux.conf      # tmux 設定
├── bin/            # コマンドエイリアス（vim -> nvim）
│   ├── vim -> nvim
│   └── vi -> nvim
├── nvim/           # LazyVim 設定
│   ├── init.lua
│   └── lua/config/
│       ├── lazy.lua      # プラグイン管理
│       ├── options.lua   # オプション設定
│       ├── keymaps.lua   # キーマップ
│       └── autocmds.lua  # 自動コマンド
├── setup.sh        # セットアップスクリプト
└── README.md
```

## クイックセットアップ

```bash
# リポジトリをクローン
git clone https://github.com/YOUR_USERNAME/dotfile.git ~/dotfile

# セットアップスクリプト実行
cd ~/dotfile && ./setup.sh

# シェル再起動
exec $SHELL
```

## 前提条件

以下のツールをインストールしてください：

```bash
# Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 必須ツール
brew install neovim fzf eza ripgrep fd

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## 手動セットアップ

```bash
# シンボリックリンク作成
ln -sf ~/dotfile/.zshrc ~/.zshrc
ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfile/nvim ~/.config/nvim
ln -sf ~/dotfile/bin ~/bin

# 機密情報用ファイル作成（Git 管理外）
touch ~/.secrets
chmod 600 ~/.secrets

# Neovim 初回起動（プラグインが自動インストールされる）
nvim
```

## 主な機能

### vim → nvim

`vim` または `vi` コマンドは自動的に Neovim を起動します（`~/bin` 経由）。

### Zsh

- **Oh My Zsh** + **Powerlevel10k**: 美しいプロンプト
- **fzf**: ファジーファインダー（Ctrl+R で履歴検索）
- **z**: ディレクトリジャンプ（`zf` で fzf 連携）
- **M2/ARM64 対応**: Apple Silicon Mac 対応

### tmux

- **プレフィックス**: `Ctrl+W`
- **ペイン操作**: h/j/k/l で移動、2/3 で分割
- **コピーモード**: vi 風キーバインド、pbcopy 連携
- **focus-events**: Neovim の autoread に対応

### Neovim (LazyVim)

- **vtsls**: TypeScript/JavaScript LSP
- **Claude Code 連携**: 外部ファイル変更の自動検出
- **カスタムキーマップ**: `s` プレフィックスでウィンドウ操作

#### よく使うキーマップ

| キー | 機能 |
|------|------|
| `gd` | 定義ジャンプ |
| `gr` | 参照一覧 |
| `K` | ドキュメント表示 |
| `<Space>ff` | ファイル検索 |
| `<Space>fg` | 全文検索 |
| `<Space>e` | ファイルツリー |

## fzf 関数

```bash
zf     # z + fzf でディレクトリ移動
fkill  # プロセス選択して kill
fb     # Git ブランチ切り替え
```

## 機密情報

API トークンなどの機密情報は `~/.secrets` に記載してください：

```bash
# ~/.secrets（Git にはコミットしない）
export ATLASSIAN_API_TOKEN=xxx
export CIRCLECI_TOKEN=xxx
```
