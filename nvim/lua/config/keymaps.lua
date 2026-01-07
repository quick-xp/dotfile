-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 's' プレフィックスによるウィンドウ操作（既存設定から移植）
keymap("n", "s", "<Nop>", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sJ", "<C-w>J", opts)
keymap("n", "sK", "<C-w>K", opts)
keymap("n", "sL", "<C-w>L", opts)
keymap("n", "sH", "<C-w>H", opts)
keymap("n", "sn", ":tabnext<CR>", opts)
keymap("n", "sp", ":tabprevious<CR>", opts)
keymap("n", "sr", "<C-w>r", opts)
keymap("n", "s=", "<C-w>=", opts)
keymap("n", "sw", "<C-w>w", opts)
keymap("n", "so", "<C-w>_<C-w>|", opts)
keymap("n", "sO", "<C-w>=", opts)
keymap("n", "ss", ":split<CR>", opts)
keymap("n", "sv", ":vsplit<CR>", opts)
keymap("n", "sq", ":q<CR>", opts)
keymap("n", "sQ", ":bdelete<CR>", opts)
keymap("n", "st", ":tabnew<CR>", opts)

-- バッファ操作
keymap("n", "sN", ":bnext<CR>", opts)
keymap("n", "sP", ":bprevious<CR>", opts)

-- 検索ハイライト解除
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- ビジュアルモードでのインデント維持
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 行移動（ビジュアルモード）
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- ターミナルモードからの脱出
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
