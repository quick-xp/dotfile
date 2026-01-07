-- Markdown プレビュー（左右分割）
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- デフォルトでは通常表示（プレビューしない）
    initial_state = false,
  },
  keys = {
    { "<leader>mp", "<cmd>Markview splitToggle<cr>", desc = "Markdown Preview Split" },
    { "<leader>mt", "<cmd>Markview toggle<cr>", desc = "Markdown Toggle Render" },
  },
}
