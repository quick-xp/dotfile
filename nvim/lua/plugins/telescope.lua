-- Telescope の検索除外設定
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        "build/",
        ".next/",
        ".nuxt/",
        "coverage/",
        ".git/",
        "%.lock",
        "package%-lock%.json",
        "yarn%.lock",
        "pnpm%-lock%.yaml",
        "%.min%.js",
        "%.min%.css",
        "%.map",
      },
      mappings = {
        i = {
          -- Ctrl+g で結果をさらにフィルタ（fuzzy）
          ["<C-g>"] = function(prompt_bufnr)
            require("telescope.actions").to_fuzzy_refine(prompt_bufnr)
          end,
        },
      },
    },
  },
  keys = {
    { "<leader>gH", "<cmd>Telescope git_bcommits<cr>", desc = "File Git History (Telescope)" },
  },
}
