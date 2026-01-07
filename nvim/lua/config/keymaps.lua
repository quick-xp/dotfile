-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- ウィンドウ操作（s プレフィックス）
vim.keymap.set("n", "sh", "<C-w>h", opts)
vim.keymap.set("n", "sj", "<C-w>j", opts)
vim.keymap.set("n", "sk", "<C-w>k", opts)
vim.keymap.set("n", "sl", "<C-w>l", opts)
vim.keymap.set("n", "ss", "<cmd>split<cr>", opts)
vim.keymap.set("n", "sv", "<cmd>vsplit<cr>", opts)
vim.keymap.set("n", "sq", "<cmd>q<cr>", opts)

-- ウィンドウズーム トグル（tmux の Ctrl+w z と同等）
local zoom_is_zoomed = false
local NEOTREE_WIDTH = 70  -- explorer.lua と同じ値

local function restore_neotree_width()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if ft == "neo-tree" then
      vim.api.nvim_win_set_width(win, NEOTREE_WIDTH)
      break
    end
  end
end

vim.keymap.set("n", "sz", function()
  if vim.fn.winnr("$") == 1 then return end

  if zoom_is_zoomed then
    vim.cmd("wincmd =")
    restore_neotree_width()
    zoom_is_zoomed = false
  else
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
    zoom_is_zoomed = true
  end
end, { noremap = true, silent = true, desc = "Toggle zoom window" })

-- tmux リサイズ時にズーム状態を維持
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if zoom_is_zoomed then
      vim.cmd("wincmd _")
      vim.cmd("wincmd |")
    end
  end,
})

-- 検索ハイライト解除
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- ビジュアルモードでのインデント維持
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- 行移動（ビジュアルモード）
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- ターミナルモードからの脱出
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
