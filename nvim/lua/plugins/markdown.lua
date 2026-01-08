-- Markdown プレビュー（左右分割）
return {
  -- markview.nvim を使用
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      preview = {
        -- デフォルトでは通常表示（プレビューしない）
        enable = false,
      },
    },
    keys = {
      { "<leader>mp", "<cmd>Markview splitToggle<cr>", desc = "Markdown Preview Split" },
      {
        "<leader>mP",
        function()
          vim.cmd("Markview splitToggle")
          vim.defer_fn(function()
            vim.cmd("wincmd l")  -- 右のプレビューに移動
            vim.cmd("only")      -- 他のウィンドウを閉じる
          end, 100)
        end,
        desc = "Markdown Preview Fullscreen",
      },
      { "<leader>mt", "<cmd>Markview Enable<cr>", desc = "Markdown Enable Render" },
      {
        "<leader>mm",
        function()
          -- 現在のファイルを保存
          vim.cmd("silent! write")
          local filepath = vim.fn.expand("%:p")
          -- tmux で右側にペインを開いて mcat-mermaid を実行
          local cmd = string.format(
            "tmux split-window -h 'mcat-mermaid %s; read -n 1'",
            vim.fn.shellescape(filepath)
          )
          vim.fn.system(cmd)
        end,
        desc = "Mermaid Preview (mcat)",
        ft = "markdown",
      },
    },
  },
  -- 干渉するプラグインを無効化
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    init = function()
      -- Safari でプレビュー（普段使わないから専用にできる）
      vim.g.mkdp_browser = "safari"
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_combine_preview = 0
    end,
    keys = {
      { "<leader>mb", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview (Browser)" },
    },
  },
}
