-- Neotest configuration for Jest (NestJS/TypeScript)
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = function(file)
            -- プロジェクトルートの jest.config.js を探す
            local root = vim.fn.getcwd()
            if vim.fn.filereadable(root .. "/jest.config.ts") == 1 then
              return root .. "/jest.config.ts"
            end
            return root .. "/jest.config.js"
          end,
          cwd = function()
            return vim.fn.getcwd()
          end,
          env = { TZ = "UTC" }, -- api_main の設定に合わせる
        },
      },
    },
  },
}
