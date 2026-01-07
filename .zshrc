# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===========================================
# M2/ARM64 対応
# ===========================================
if (( $+commands[arch] )); then
  alias a64="exec arch -arch arm64e '$SHELL'"
  alias x64="exec arch -arch x86_64 '$SHELL'"
fi

function runs_on_ARM64() { [[ `uname -m` = "arm64" ]]; }
function runs_on_X86_64() { [[ `uname -m` = "x86_64" ]]; }

# ===========================================
# Oh My Zsh 設定
# ===========================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  fzf
)

source $ZSH/oh-my-zsh.sh

# ===========================================
# PATH 設定
# ===========================================
typeset -U path PATH

# Homebrew (Apple Silicon 優先)
if runs_on_ARM64; then
  export PATH="/opt/homebrew/bin:$PATH"
fi
export PATH="/usr/local/bin:$PATH"

# ユーザーローカル
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Node (ローカル node_modules)
export PATH="$PATH:./node_modules/.bin"

# Go
export GOPATH=$HOME/go
export GOROOT="/usr/local/go"
export PATH="$GOROOT/bin:$GOPATH/bin:/usr/local/go/bin:$PATH"

# Flutter
export PATH="$HOME/004_project2/flutter/bin:$PATH"

# Amplify
export PATH="$HOME/.amplify/bin:$PATH"

# Rancher Desktop
export PATH="$HOME/.rd/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# npm-global
export PATH="$HOME/.npm-global/bin:$PATH"

# ===========================================
# バージョンマネージャー
# ===========================================
# anyenv (nodenv を管理)
if [[ -d "$HOME/.anyenv" ]]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# rbenv (anyenv 経由でない場合のフォールバック)
if [[ -d "$HOME/.rbenv" ]] && ! command -v rbenv &>/dev/null; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# ===========================================
# 環境変数
# ===========================================
export GO15VENDOREXPERIMENT=1
export EDITOR=nvim

# ===========================================
# エイリアス
# ===========================================
# eza (exa の後継)
if command -v eza &>/dev/null; then
  alias ls='eza'
  alias ll='eza -l'
  alias lsa='eza -la'
  alias la='eza -la'
  alias tree='eza --tree'
elif command -v exa &>/dev/null; then
  alias ls='exa'
  alias ll='exa -l'
  alias lsa='exa -la'
fi

# Git
alias g='git'
alias gla="git log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias git-remove='git rm $(git ls-files --deleted)'

# その他
alias grep="grep -n --color=auto"
alias tag='ctags --langmap=RUBY:.rb --exclude="*.js" --exclude=".git*" -R .'
alias mysqlstart='brew services start mysql@8.0'
alias mysqlstop='brew services stop mysql@8.0'
alias v1rspec='docker compose exec -e RAILS_ENV=test api bundle exec rspec'

# Vim → Neovim
alias vim='nvim'
alias vi='nvim'

# ===========================================
# fzf 設定
# ===========================================
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

  # z + fzf でディレクトリ移動
  function zf() {
    local dir
    dir=$(z -l 2>&1 | fzf --tac | awk '{ print $2 }')
    if [[ -n "$dir" ]]; then
      cd "$dir"
    fi
  }

  # プロセス kill
  function fkill() {
    local pid
    pid=$(ps aux | fzf --header-lines=1 | awk '{ print $2 }')
    if [[ -n "$pid" ]]; then
      kill $pid
    fi
  }

  # Git ブランチ切り替え
  function fb() {
    local branch
    branch=$(git branch -a | fzf | sed 's/^[* ]*//' | sed 's|remotes/origin/||')
    if [[ -n "$branch" ]]; then
      git checkout "$branch"
    fi
  }
fi

# ===========================================
# 機密情報の読み込み
# ===========================================
[[ -f ~/.secrets ]] && source ~/.secrets

# ===========================================
# ツール固有の設定
# ===========================================
# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# ===========================================
# ローカル設定
# ===========================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
