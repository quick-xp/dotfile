-- Flash のキーマップを変更（s プレフィックスとの競合回避）
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- Flash のラベルモードを無効化（s キーを使わせない）
    modes = {
      search = { enabled = false },
      char = { enabled = true, keys = { "f", "F", "t", "T" } },
    },
  },
  keys = {
    -- デフォルトの s/S を明示的に無効化
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },
    -- 代替キーで Flash を使用
    { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
