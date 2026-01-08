-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 外部ファイル変更の自動検出
vim.opt.autoread = true
vim.opt.updatetime = 300

-- 自動的にファイル変更をチェック
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- 外部変更時の処理
vim.api.nvim_create_autocmd("FileChangedShell", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local modified = vim.bo[buf].modified

    if not modified then
      -- ローカル変更なし → 自動リロード
      vim.cmd("edit")
      vim.notify("File reloaded (changed externally)", vim.log.levels.INFO)
    else
      -- ローカル変更あり → 選択肢を表示
      vim.ui.select(
        { "Load external changes (lose local)", "Keep local changes", "Show diff" },
        { prompt = "File changed externally. What to do?" },
        function(choice)
          if choice == "Load external changes (lose local)" then
            vim.cmd("edit!")
            vim.notify("Loaded external changes", vim.log.levels.INFO)
          elseif choice == "Keep local changes" then
            vim.notify("Keeping local changes", vim.log.levels.INFO)
          elseif choice == "Show diff" then
            -- 外部変更との diff を表示
            vim.cmd("diffthis")
            vim.cmd("vnew")
            vim.cmd("read #")  -- 元ファイルを読み込み
            vim.cmd("diffthis")
            vim.notify("Showing diff with external changes", vim.log.levels.INFO)
          end
        end
      )
    end
    return true  -- デフォルト動作を抑制
  end,
})

-- 日本語対応
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,euc-jp,sjis,cp932,iso-2022-jp"

-- スペルチェック無効化（日本語に下線が出る問題を回避）
vim.opt.spell = false

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
