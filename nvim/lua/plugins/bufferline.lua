-- bufferline の設定（バッファとタブを区別しやすく）
return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- 右端にタブを表示
        always_show_bufferline = true,
        show_tab_indicators = true,
        separator_style = "thin",
        -- タブとバッファを区別
        mode = "buffers", -- "buffers" or "tabs"
        -- 右端にタブページ表示
        custom_areas = {
          right = function()
            local tabs = vim.fn.tabpagenr("$")
            if tabs > 1 then
              local current = vim.fn.tabpagenr()
              return {
                { text = " 󰓩 Tab " .. current .. "/" .. tabs .. " ", fg = "#7aa2f7" },
              }
            end
            return {}
          end,
        },
      },
    },
  },
}
