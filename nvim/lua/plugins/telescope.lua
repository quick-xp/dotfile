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
    },
  },
}
