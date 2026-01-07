-- Markdown プレビュー（左右分割）
return {
  "OXY2DEV/markview.nvim",
  lazy = false,  -- 公式推奨：lazy-load しない
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>mp", "<cmd>Markview splitToggle<cr>", desc = "Markdown Preview Split" },
  },
}
