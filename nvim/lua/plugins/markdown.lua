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
      { "<leader>mt", "<cmd>Markview Enable<cr>", desc = "Markdown Enable Render" },
    },
  },
  -- 干渉するプラグインを無効化
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  { "iamcco/markdown-preview.nvim", enabled = false },
}
