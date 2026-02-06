return {
  {
    "saghen/blink.cmp",
    build = "cbargo build --release",
    version = "1.*",
    opts = {
      signature = {
        enabled = true,
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          -- function(a, b)
          -- 	if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
          -- 		return
          --       	end
          -- 	return b.client_name == 'emmet_language_server'
          -- end,
          "exact",
          "score",
          "sort_text",
        },
      },
      sources = {
        default = { "snippets", "lsp", "buffer", "path" },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
      },
      keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = "default",

        ["<Tab>"] = { "select_next", "fallback" },
        ["<C-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        -- ["<S-space>"] = {
        -- 	function(cmp)
        -- 		cmp.show()
        -- 	end,
        -- },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.completion.spell,
          -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      lsp.lua_ls.setup({ capabilities = capabilities })
      lsp.somesass_ls.setup({ capabilities = capabilities })
      lsp.emmet_language_server.setup({ capabilities = capabilities })
      lsp.cssls.setup({ capabilities = capabilities })

      -- clangd LSP server configuration with advanced settings
      lsp.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",          -- Index project in background
          "--clang-tidy",                 -- Enable clang-tidy diagnostics
          "--header-insertion=iwyu",      -- Use "Include What You Use" for headers
          "--completion-style=detailed",  -- Detailed completion information
          "--function-arg-placeholders",  -- Show placeholders for function arguments
          "--fallback-style=llvm",        -- LLVM style as fallback
        },
        init_options = {
          usePlaceholders = true,         -- Enable parameter placeholders in completions
          completeUnimported = true,      -- Suggest completions for unimported symbols
          clangdFileStatus = true,        -- Show file compilation status
        },
        settings = {
          clangd = {
            InlayHints = {
              Enabled = true,
              ParameterNames = true,      -- Show parameter names as hints
              DeducedTypes = true,        -- Show deduced types
              Designators = true,         -- Show designated initializers
            },
          },
        },
      })

      local lsp_utils = require("utils.lsp")

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", lsp_utils.goto_definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>w", function()
        vim.lsp.buf.format()
        vim.cmd("w")
      end, {})
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, _)
          -- vim.keymap.set("n", "<C-w>o", ":TSToolsAddMissingImports<CR>", {})
        end,
        -- settings = {
        -- jsx_close_tag = {
        --   enable = true,
        --   filetypes = { "javascriptreact", "typescriptreact" },
        -- }
        -- }
      })
    end,
  },
}
