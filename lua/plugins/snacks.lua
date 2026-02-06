return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
  },
  config = function ()
		vim.api.nvim_set_hl(0, "SnacksPicker", { link = "Normal" })
		vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#f2f2f2" })
  end,
  opts = {
    explorer = {
      ---@class snacks.picker.explorer.Config: snacks.picker.files.Config|{}
      ---@field follow_file? boolean follow the file from the current buffer
      ---@field tree? boolean show the file tree (default: true)
      ---@field git_status? boolean show git status (default: true)
      ---@field git_status_open? boolean show recursive git status for open directories
      ---@field git_untracked? boolean needed to show untracked git status
      ---@field diagnostics? boolean show diagnostics
      ---@field diagnostics_open? boolean show recursive diagnostics for open directories
      ---@field watch? boolean watch for file changes
      ---@field exclude? string[] exclude glob patterns
      ---@field include? string[] include glob patterns. These take precedence over `exclude`, `ignored` and `hidden`
      {
        finder = "explorer",
        sort = { fields = { "sort" } },
        supports_live = true,
        tree = true,
        watch = true,
        diagnostics = true,
        diagnostics_open = false,
        git_status = true,
        git_status_open = false,
        git_untracked = true,
        follow_file = true,
        focus = "list",
        auto_close = false,
        jump = { close = false },
        layout = { preset = "sidebar", preview = false, position = "right" },
        -- to show the explorer to the right, add the below to
        -- your config under `opts.picker.sources.explorer`
        -- layout = { layout = { position = "right" } },
        formatters = {
          file = { filename_only = true },
          severity = { pos = "right" },
        },
        matcher = { sort_empty = false, fuzzy = false },
        config = function(opts)
          return require("snacks.picker.source.explorer").setup(opts)
        end,
        win = {
          list = {
            keys = {
              ["<BS>"] = "explorer_up",
              ["l"] = "confirm",
              ["h"] = "explorer_close", -- close directory
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open", -- open with system application
              ["P"] = "toggle_preview",
              ["y"] = { "explorer_yank", mode = { "n", "x" } },
              ["p"] = "explorer_paste",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["<leader>/"] = "picker_grep",
              ["<c-t>"] = "terminal",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
              ["]g"] = "explorer_git_next",
              ["[g"] = "explorer_git_prev",
              ["]d"] = "explorer_diagnostic_next",
              ["[d"] = "explorer_diagnostic_prev",
              ["]w"] = "explorer_warn_next",
              ["[w"] = "explorer_warn_prev",
              ["]e"] = "explorer_error_next",
              ["[e"] = "explorer_error_prev",
            },
          },
        },
      }
    },
    picker = {},
  },
}
