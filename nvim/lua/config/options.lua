-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Claude Code との連携（外部ファイル変更の自動検出）
vim.opt.autoread = true
vim.opt.updatetime = 300

-- 日本語対応
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,euc-jp,sjis,cp932,iso-2022-jp"

-- インデント設定（2スペース）
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- 行番号（絶対表示）
vim.opt.number = true
vim.opt.relativenumber = false

-- その他の推奨設定
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

-- スワップファイル無効化（警告回避）
vim.opt.swapfile = false

-- マウスドラッグ選択でクリップボードにコピー
vim.opt.mouse = "a"
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.fn.setreg("+", vim.fn.getreg('"'))
  end,
})
