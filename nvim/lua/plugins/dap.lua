-- デバッグ設定 (nvim-dap)
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dx", function()
        require("dap").terminate()
        require("dapui").close()
      end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- DAP UI 設定（neo-tree と競合しないよう右側に配置）
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "watches", size = 0.2 },
            },
            size = 50,
            position = "right",  -- neo-tree は左なので右に
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
      })

      -- Virtual Text (変数の値を行に表示)
      require("nvim-dap-virtual-text").setup()

      -- DAP UI を自動で開く/閉じる
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Node.js / TypeScript アダプター設定
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- NestJS 用の設定
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          -- NestJS: npm run start:debug にアタッチ
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to NestJS (port 9229)",
            port = 9229,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          -- NestJS: 直接起動
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch NestJS",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "start:debug" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            console = "integratedTerminal",
          },
          -- 現在のファイルを実行
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end

      -- ブレークポイントのアイコン（目立つように）
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticError", linehl = "DiffDelete", numhl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DiagnosticWarn", linehl = "DiffChange", numhl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DiagnosticOk", linehl = "DiffAdd", numhl = "DiagnosticOk" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⭕", texthl = "DiagnosticError" })
    end,
  },

  -- Mason で js-debug-adapter をインストール
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },
}
