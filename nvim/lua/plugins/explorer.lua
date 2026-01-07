-- Neo-tree（ファイルツリー）の設定
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 50,
        position = "left",
        mappings = {
          ["s"] = "none",  -- sh/sj/sk/sl のために無効化
          ["S"] = "open_vsplit",
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
