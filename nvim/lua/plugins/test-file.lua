-- ソースファイル ↔ テストファイル の切り替え
return {
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<leader>tf",
        function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.expand("%:p:h")
          local filename = vim.fn.expand("%:t")
          local target = nil

          -- __dev__ 内のテストファイルからソースへ
          if dir:match("/__dev__$") then
            local parent_dir = dir:gsub("/__dev__$", "")
            local source_name = filename:gsub("%.spec%.ts$", ".ts"):gsub("%.test%.ts$", ".ts")
            target = parent_dir .. "/" .. source_name
          -- ソースファイルから __dev__ 内のテストへ
          elseif filename:match("%.ts$") and not filename:match("%.spec%.ts$") and not filename:match("%.test%.ts$") then
            local dev_dir = dir .. "/__dev__"
            local spec_name = filename:gsub("%.ts$", ".spec.ts")
            local test_name = filename:gsub("%.ts$", ".test.ts")

            -- __dev__ フォルダ内を優先
            if vim.fn.isdirectory(dev_dir) == 1 then
              local spec_file = dev_dir .. "/" .. spec_name
              local test_file = dev_dir .. "/" .. test_name
              if vim.fn.filereadable(spec_file) == 1 then
                target = spec_file
              elseif vim.fn.filereadable(test_file) == 1 then
                target = test_file
              else
                target = spec_file -- 新規作成用
              end
            else
              -- 同じフォルダ内の .spec.ts / .test.ts
              local spec_file = dir .. "/" .. spec_name
              local test_file = dir .. "/" .. test_name
              if vim.fn.filereadable(spec_file) == 1 then
                target = spec_file
              elseif vim.fn.filereadable(test_file) == 1 then
                target = test_file
              else
                -- __dev__ フォルダを作成して開く
                target = dev_dir .. "/" .. spec_name
              end
            end
          -- 同じフォルダ内の .spec.ts からソースへ
          elseif filename:match("%.spec%.ts$") then
            target = dir .. "/" .. filename:gsub("%.spec%.ts$", ".ts")
          elseif filename:match("%.test%.ts$") then
            target = dir .. "/" .. filename:gsub("%.test%.ts$", ".ts")
          end

          if target then
            vim.cmd("edit " .. target)
          else
            vim.notify("No test/source file pattern matched", vim.log.levels.WARN)
          end
        end,
        desc = "Go to Test/Source file",
      },
    },
  },
}
