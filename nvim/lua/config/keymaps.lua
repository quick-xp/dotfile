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
-- レイアウトを保存して復元する方式
local zoom_state = {
  is_zoomed = false,
  saved_layout = nil,
}

vim.keymap.set("n", "sz", function()
  local win_count = vim.fn.winnr("$")
  if win_count == 1 then
    return
  end

  if zoom_state.is_zoomed and zoom_state.saved_layout then
    -- 復元
    vim.cmd("silent! " .. zoom_state.saved_layout)
    zoom_state.is_zoomed = false
    zoom_state.saved_layout = nil
  else
    -- レイアウト保存してズーム
    zoom_state.saved_layout = vim.fn.winrestcmd()
    zoom_state.is_zoomed = true
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
  end
end, { noremap = true, silent = true, desc = "Toggle zoom window" })

-- tmux リサイズ時にズーム状態を維持
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if zoom_state.is_zoomed then
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
