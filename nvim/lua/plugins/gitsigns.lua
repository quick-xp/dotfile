-- gitsigns の設定（git blame 強化）
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- 現在行の blame を常に表示（バーチャルテキスト）
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 行末に表示
      delay = 300,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary> (<abbrev_sha>)",
  },
  keys = {
    -- 詳細な blame をポップアップ表示
    {
      "<leader>gB",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Git Blame (詳細)",
    },
    -- 現在行の blame 表示トグル
    {
      "<leader>gb",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      desc = "Git Blame 表示トグル",
    },
    -- Hunk プレビュー
    {
      "<leader>hp",
      "<cmd>Gitsigns preview_hunk<cr>",
      desc = "Hunk Preview",
    },
  },
}
