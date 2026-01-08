-- lazygit の設定改善
return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        -- floating window の設定
        win = {
          style = "lazygit",
          width = 0,  -- フルスクリーン
          height = 0,
        },
        configure = true,
      },
      -- terminal でマウスを無効化
      terminal = {
        win = {
          wo = {
            -- terminal window でマウスを無効にする
            winblend = 0,
          },
        },
      },
    },
    keys = {
      -- lazygit 内で Esc が効くように
      {
        "<leader>gg",
        function()
          -- 一時的にマウスを無効化
          local mouse = vim.o.mouse
          vim.o.mouse = ""
          require("snacks").lazygit()
          -- lazygit 終了後にマウスを戻す
          vim.api.nvim_create_autocmd("TermClose", {
            once = true,
            callback = function()
              vim.o.mouse = mouse
            end,
          })
        end,
        desc = "Lazygit",
      },
    },
  },
}
