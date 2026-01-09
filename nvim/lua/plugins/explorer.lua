-- Neo-tree（ファイルツリー）の設定
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_diagnostics = false,
      window = {
        width = 70,
        position = "left",
        mappings = {
          ["s"] = "none",  -- sh/sj/sk/sl のために無効化
          ["S"] = "open_vsplit",
          ["<C-p>"] = { "toggle_preview", config = { use_float = true } },
          ["<2-LeftMouse>"] = "open",
          ["<LeftMouse>"] = "focus_node",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          -- 常に非表示（検索対象外）
          never_show = {
            ".git",
            ".obsidian",
            ".DS_Store",
            "node_modules",
            "coverage",
            "dist",
          },
          -- .claude は表示する（never_show に入れない）
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
