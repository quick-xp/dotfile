-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- 日本語にスペルチェックの下線が出るので無効化
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Claude Code との連携（外部でファイルが変更されたときに自動リロード）
vim.api.nvim_create_autocmd({
  "FocusGained",
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "TermClose",
  "TermLeave",
}, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- 外部で変更された場合に通知
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("ファイルが外部で変更されました", vim.log.levels.WARN)
  end,
})

-- ファイル保存時に末尾の空白を削除
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- oldfiles から無効なエントリを除外（shada 保存前）
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local valid_files = {}
    for _, file in ipairs(vim.v.oldfiles) do
      -- 特殊バッファを除外
      local is_special = file:match("neo%-tree")
        or file:match("^snacks://")
        or file:match("^octo://")
        or file:match("^diffview://")
        or file:match("%[%d+%]$")
        or file:match("^/private/var/folders")  -- 一時ファイル
      if not is_special and vim.fn.filereadable(file) == 1 then
        table.insert(valid_files, file)
      end
    end
    vim.v.oldfiles = valid_files
  end,
})
