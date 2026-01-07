-- GitHub PR/Issue レビュー (octo.nvim)
return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>op", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>os", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
      { "<leader>oo", "<cmd>Octo<cr>", desc = "Octo actions" },
    },
    opts = {
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      picker = "telescope",
      -- PR レビューの設定
      pull_requests = {
        order_by = {
          field = "UPDATED_AT",
          direction = "DESC",
        },
      },
      -- Issue の設定
      issues = {
        order_by = {
          field = "UPDATED_AT",
          direction = "DESC",
        },
      },
      -- UI 設定
      ui = {
        use_signcolumn = true,
      },
      -- マッピング (PR/Issue バッファ内)
      mappings = {
        issue = {
          close_issue = { lhs = "<leader>ic", desc = "close issue" },
          reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
          list_issues = { lhs = "<leader>il", desc = "list open issues" },
          add_comment = { lhs = "<leader>ca", desc = "add comment" },
          delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        },
        pull_request = {
          checkout_pr = { lhs = "<leader>pc", desc = "checkout PR" },
          merge_pr = { lhs = "<leader>pm", desc = "merge PR" },
          list_commits = { lhs = "<leader>pC", desc = "list commits" },
          list_changed_files = { lhs = "<leader>f", desc = "list changed files" },
          show_pr_diff = { lhs = "<leader>d", desc = "show PR diff" },
          add_reviewer = { lhs = "<leader>ra", desc = "add reviewer" },
          add_comment = { lhs = "<leader>ca", desc = "add comment" },
          close_issue = { lhs = "<leader>px", desc = "close PR" },
          reopen_issue = { lhs = "<leader>po", desc = "reopen PR" },
        },
        review_thread = {
          add_comment = { lhs = "<leader>ca", desc = "add comment" },
          add_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
          delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "approve review" },
          comment_review = { lhs = "<C-m>", desc = "comment review" },
          request_changes = { lhs = "<C-r>", desc = "request changes" },
        },
        review_diff = {
          add_review_comment = { lhs = "<leader>ca", desc = "add review comment" },
          add_review_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
          focus_files = { lhs = "<leader>e", desc = "focus files" },
          toggle_files = { lhs = "<leader>b", desc = "toggle files" },
          next_thread = { lhs = "]t", desc = "next thread" },
          prev_thread = { lhs = "[t", desc = "prev thread" },
          select_next_entry = { lhs = "]f", desc = "next file" },
          select_prev_entry = { lhs = "[f", desc = "prev file" },
        },
      },
    },
  },
}
