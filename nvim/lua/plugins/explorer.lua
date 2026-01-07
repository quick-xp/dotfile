-- Neo-tree（ファイルツリー）の設定
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 50,
        position = "left",
        mappings = {
          -- s プレフィックスの競合を解消
          ["s"] = "none",
          ["S"] = "open_vsplit",  -- 代わりに S で縦分割
          -- sN/sP との競合を解消
          ["P"] = "none",
          ["N"] = "none",
          -- プレビューは別キーに
          ["<C-p>"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
    },
  },
  -- snacks.explorer を無効化
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
}
