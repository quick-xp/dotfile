-- Rails 開発用設定
return {
  -- vim-rails（:Emodel, :Econtroller など）
  {
    "tpope/vim-rails",
    event = "VeryLazy", -- 常にロード
    keys = {
      { "<leader>rc", ":Econtroller ", desc = "Rails Controller" },
      { "<leader>rm", ":Emodel ", desc = "Rails Model" },
      { "<leader>rv", ":Eview ", desc = "Rails View" },
      { "<leader>rh", ":Ehelper ", desc = "Rails Helper" },
      { "<leader>rt", "<cmd>A<cr>", desc = "Rails Alternate (Test)" },
      { "<leader>rr", "<cmd>R<cr>", desc = "Rails Related" },
    },
  },

  -- vim-bundler（Gemfile 関連）
  { "tpope/vim-bundler", event = "VeryLazy" },
}
