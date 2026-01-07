-- diffview.nvim: 差分ビューア（ファイル一覧パネル付き）
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    config = function()
      local actions = require("diffview.actions")

      -- デフォルト: 少し広めのコンテキスト (15行)
      local is_full_context = false

      vim.cmd("set diffopt+=context:15")

      -- コンテキスト切り替えトグル
      vim.keymap.set("n", "<leader>df", function()
        is_full_context = not is_full_context
        if is_full_context then
          vim.cmd("set diffopt-=context:15")
          vim.cmd("set diffopt+=context:99999")
          vim.notify("Diff: ファイル全体表示", vim.log.levels.INFO)
        else
          vim.cmd("set diffopt-=context:99999")
          vim.cmd("set diffopt+=context:15")
          vim.notify("Diff: 通常表示", vim.log.levels.INFO)
        end
        -- 全ウィンドウで diff を再計算
        vim.cmd("windo diffupdate")
        vim.cmd("normal! zX")
      end, { desc = "Toggle diff full context" })

      require("diffview").setup({
        enhanced_diff_hl = true,
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 40,
          },
        },
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
            { "n", "sh", "<C-w>h", { desc = "Go left" } },
            { "n", "sl", "<C-w>l", { desc = "Go right" } },
            { "n", "sj", "<C-w>j", { desc = "Go down" } },
            { "n", "sk", "<C-w>k", { desc = "Go up" } },
          },
          file_panel = {
            { "n", "s", false },  -- s を無効化
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
            { "n", "sh", "<C-w>h", { desc = "Go left" } },
            { "n", "sl", "<C-w>l", { desc = "Go right" } },
            { "n", "sj", "<C-w>j", { desc = "Go down" } },
            { "n", "sk", "<C-w>k", { desc = "Go up" } },
            { "n", "gf", actions.goto_file_tab, { desc = "Open file in new tab" } },
          },
        },
      })

      -- diffview 用の filetype で sh/sl を有効化
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "DiffviewFiles", "DiffviewFileHistory" },
        callback = function()
          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "sh", "<C-w>h", opts)
          vim.keymap.set("n", "sl", "<C-w>l", opts)
          vim.keymap.set("n", "sj", "<C-w>j", opts)
          vim.keymap.set("n", "sk", "<C-w>k", opts)
        end,
      })
    end,
  },
}
