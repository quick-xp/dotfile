-- ステータスラインの設定
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1,  -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス, 3: 絶対パス(~を使用)
          shorting_target = 60,  -- パス省略の閾値（大きいほど長く表示）
        },
      },
    },
  },
}
