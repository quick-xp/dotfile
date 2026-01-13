#!/bin/bash
# dotfiles セットアップスクリプト
# 新しい環境で実行してください

set -e

DOTFILE_DIR="$HOME/dotfile"

echo "=== dotfiles セットアップ開始 ==="

# シンボリックリンク作成
echo "シンボリックリンクを作成中..."

# .zshrc
if [[ -f ~/.zshrc && ! -L ~/.zshrc ]]; then
  mv ~/.zshrc ~/.zshrc.bak
  echo "  ~/.zshrc をバックアップしました"
fi
ln -sf "$DOTFILE_DIR/.zshrc" ~/.zshrc
echo "  ~/.zshrc -> $DOTFILE_DIR/.zshrc"

# .tmux.conf
if [[ -f ~/.tmux.conf && ! -L ~/.tmux.conf ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.bak
  echo "  ~/.tmux.conf をバックアップしました"
fi
ln -sf "$DOTFILE_DIR/.tmux.conf" ~/.tmux.conf
echo "  ~/.tmux.conf -> $DOTFILE_DIR/.tmux.conf"

# nvim
mkdir -p ~/.config
if [[ -d ~/.config/nvim && ! -L ~/.config/nvim ]]; then
  mv ~/.config/nvim ~/.config/nvim.bak
  echo "  ~/.config/nvim をバックアップしました"
fi
ln -sf "$DOTFILE_DIR/nvim" ~/.config/nvim
echo "  ~/.config/nvim -> $DOTFILE_DIR/nvim"

# ghostty
mkdir -p ~/.config/ghostty
if [[ -f ~/.config/ghostty/config && ! -L ~/.config/ghostty/config ]]; then
  mv ~/.config/ghostty/config ~/.config/ghostty/config.bak
  echo "  ~/.config/ghostty/config をバックアップしました"
fi
ln -sf "$DOTFILE_DIR/ghostty/config" ~/.config/ghostty/config
echo "  ~/.config/ghostty/config -> $DOTFILE_DIR/ghostty/config"

# bin
if [[ -d ~/bin && ! -L ~/bin ]]; then
  mv ~/bin ~/bin.bak
  echo "  ~/bin をバックアップしました"
fi
ln -sf "$DOTFILE_DIR/bin" ~/bin
echo "  ~/bin -> $DOTFILE_DIR/bin"

# .secrets 作成（存在しない場合）
if [[ ! -f ~/.secrets ]]; then
  touch ~/.secrets
  chmod 600 ~/.secrets
  echo "  ~/.secrets を作成しました（機密情報をここに記載してください）"
fi

echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "次のステップ:"
echo "  1. シェルを再起動: exec \$SHELL"
echo "  2. Neovim を起動してプラグインをインストール: nvim"
echo "  3. ~/.secrets に機密情報を記載（必要に応じて）"
